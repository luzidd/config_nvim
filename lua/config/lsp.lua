-- Advertise completion support before enabling any servers.
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Lua
require("lsp.lua")

-- Python
vim.lsp.enable("pyright")

-- TypeScript and JavaScript, including React files
vim.lsp.enable("ts_ls")

-- Rust
vim.lsp.enable("rust_analyzer")

-- Go
require("lsp.go")

-- JSON
require("lsp.json")
