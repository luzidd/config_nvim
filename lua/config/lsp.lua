-- Advertise completion support before enabling any servers.
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Lua
require("lsp.lua")

-- Python
vim.lsp.enable("pyright")

-- TypeScript
-- JavaScript
-- ts_ls supports both TypeScript and JavaScript, including React files.
vim.lsp.enable("ts_ls")

-- Rust
vim.lsp.enable("rust_analyzer")

-- Go
require("lsp.go")

-- json
require("lsp.json")

-- Add more servers as needed
