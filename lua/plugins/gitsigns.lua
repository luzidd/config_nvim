local function setup_git_keymaps(buffer)
  local gitsigns = require("gitsigns")

  local function map(keys, action, description)
    vim.keymap.set("n", keys, action, {
      buffer = buffer,
      desc = description,
    })
  end

  local function navigate_change(direction, diff_keys)
    -- Diff windows use Vim's navigation instead of Gitsigns.
    if vim.wo.diff then
      vim.cmd.normal({ diff_keys, bang = true })
      return
    end

    gitsigns.nav_hunk(direction)
  end

  -- Move between changed sections.
  map("]c", function()
    navigate_change("next", "]c")
  end, "Next Git change")

  map("[c", function()
    navigate_change("prev", "[c")
  end, "Previous Git change")

  -- Inspect changes and authorship without modifying files or the index.
  map("<leader>gp", gitsigns.preview_hunk, "Preview Git change")
  map("<leader>gb", gitsigns.blame_line, "Git blame line")
end

return {
  "lewis6991/gitsigns.nvim",
  opts = {
    -- ASCII gutter markers; no special font required.
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "-" },
      changedelete = { text = "~" },
      untracked = { text = "?" },
    },
    signs_staged_enable = false,

    -- Register shortcuts only for buffers attached to Gitsigns.
    on_attach = setup_git_keymaps,
  },
}
