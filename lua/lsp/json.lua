vim.lsp.config["jsonls"] = {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" }, -- Supports JSON and JSONC (JSON with comments)
  init_options = {
    provideFormatter = true, -- Enable formatting Support
  },
  single_file_support = true,
}

vim.lsp.enable("jsonls")
