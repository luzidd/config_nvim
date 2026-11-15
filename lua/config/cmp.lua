local cmp = require("cmp")

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

local function resume_word_completion()
  if vim.api.nvim_get_mode().mode ~= "i" then
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local column = cursor[2] -- Zero-based byte offset, also the length before the cursor.
  local line = vim.api.nvim_get_current_line()
  local text_before_cursor = line:sub(1, column)

  -- Refresh only when continuing a word.
  if text_before_cursor:match("[%w_]$") then
    cmp.complete()
  end
end

-- Request fresh candidates when resuming an existing word after Escape.
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("CompletionResume", { clear = true }),
  callback = function()
    -- Wait for insert mode and the cursor to settle.
    vim.schedule(resume_word_completion)
  end,
})
