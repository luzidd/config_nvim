-- Language navigation
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

-- File navigation and search
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search text" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Compare the current file with a selected commit.
vim.keymap.set("n", "<leader>gd", function()
  require("config.git").diff_from_commit()
end, { desc = "Diff against commit" })

-- Formatting
vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ timeout_ms = 2000, lsp_format = "never" })
end, { desc = "Format buffer" })

-- Plugin and language server management
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Plugin manager" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Language server manager" })
