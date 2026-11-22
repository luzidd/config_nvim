-- Advertise completion support before enabling any servers.
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

-- Lua
require("lsp.lua")

-- Bash and shell scripts
vim.lsp.enable("bashls")

-- Python
vim.lsp.enable("pyright")

-- TypeScript and JavaScript, including React files
vim.lsp.enable("ts_ls")

-- Rust, including standalone files outside Cargo projects.
require("lsp.rust")

-- Go
require("lsp.go")

-- JSON
require("lsp.json")
