local M = {}

local function count_changed_lines(previous_text, current_text)
  local added = 0
  local deleted = 0
  local hunks = vim.diff(previous_text, current_text, { result_type = "indices" })

  for _, hunk in ipairs(hunks) do
    deleted = deleted + hunk[2]
    added = added + hunk[4]
  end

  return string.format("+%d -%d", added, deleted)
end

local function add_diff_counts(history, root, filename, buffer)
  local lines = vim.split(history, "\n", { trimempty = true })
  local relative_path = filename:sub(#root + 2)
  local requests = {}

  for _, line in ipairs(lines) do
    local commit = line:match("^%x+")
    requests[#requests + 1] = commit .. ":" .. relative_path
  end

  -- Read all revisions in one Git process instead of one process per commit.
  local revisions = vim
    .system({ "git", "-C", root, "cat-file", "--batch" }, {
      stdin = table.concat(requests, "\n") .. "\n",
    })
    :wait()

  if revisions.code ~= 0 then
    vim.notify("Could not read file revisions; showing commits without counts.", vim.log.levels.WARN)
    return lines
  end

  -- Snapshot the buffer, including unsaved edits and its final newline.
  local current_text = table.concat(vim.api.nvim_buf_get_lines(buffer, 0, -1, false), "\n")
  if vim.bo[buffer].endofline then
    current_text = current_text .. "\n"
  end

  local output = revisions.stdout or ""
  local offset = 1
  for index, line in ipairs(lines) do
    local header_end = assert(output:find("\n", offset, true), "Incomplete Git batch response")
    local header = output:sub(offset, header_end - 1)
    local size = tonumber(header:match(" blob (%d+)$"))
    local counts = "[file absent]"
    offset = header_end + 1

    if size then
      local previous_text = output:sub(offset, offset + size - 1)
      offset = offset + size + 1 -- Skip the blob and its batch separator.

      if previous_text:find("\0", 1, true) or current_text:find("\0", 1, true) then
        counts = "[binary]"
      else
        counts = count_changed_lines(previous_text, current_text)
      end
    end

    lines[index] = line .. "  " .. counts
  end

  return lines
end

function M.diff_from_commit()
  local buffer = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buffer)
  local root = vim.fs.root(filename, ".git")

  if filename == "" or not root then
    vim.notify("Open a Git-tracked file first.", vim.log.levels.WARN)
    return
  end

  local tracked = vim.system({ "git", "-C", root, "ls-files", "--error-unmatch", "--", filename }):wait()
  if tracked.code ~= 0 then
    vim.notify("This file is not tracked by Git.", vim.log.levels.WARN)
    return
  end

  -- Limit the list to recent commits; never modify repository history.
  local history = vim
    .system({
      "git",
      "-C",
      root,
      "log",
      "-200",
      "--format=%h %ad %s",
      "--date=short",
    }, { text = true })
    :wait()

  if history.code ~= 0 then
    vim.notify("Could not read Git history: " .. (history.stderr or ""), vim.log.levels.ERROR)
    return
  end

  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local telescope_config = require("telescope.config").values

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Diff current file against commit",
      finder = require("telescope.finders").new_table({
        results = add_diff_counts(history.stdout or "", root, filename, buffer),
      }),
      sorter = telescope_config.generic_sorter({}),
      attach_mappings = function(prompt_buffer)
        actions.select_default:replace(function()
          local selected = action_state.get_selected_entry()
          actions.close(prompt_buffer)

          if not selected or not vim.api.nvim_buf_is_valid(buffer) then
            return
          end

          -- Return to the original file before opening its side-by-side diff.
          vim.api.nvim_set_current_buf(buffer)
          local commit = selected.value:match("^%x+")
          require("gitsigns").diffthis(commit)
        end)
        return true
      end,
    })
    :find()
end

return M
