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

-- Request fresh candidates when resuming an existing word after Escape.
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("CompletionResume", { clear = true }),
  callback = function()
    -- Wait for insert mode and the cursor to settle.
    vim.schedule(function()
      if vim.api.nvim_get_mode().mode == "i" then
        local cursor = vim.api.nvim_win_get_cursor(0)
        local before_cursor = vim.api.nvim_get_current_line():sub(1, cursor[2])
        -- Refresh only when continuing a word.
        if before_cursor:match("[%w_]$") then
          cmp.complete()
        end
      end
    end)
  end,
})
