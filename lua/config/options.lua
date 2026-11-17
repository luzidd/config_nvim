-- Keep line-delimited JSON separate from ordinary JSON formatting.
vim.filetype.add({
  extension = {
    jsonl = "jsonl",
    ndjson = "jsonl",
  },
})

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes" -- Reserve space for Git signs and diagnostics.
vim.opt.showmode = false -- Lualine already displays the current mode.

-- Visible whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = ">",
  precedes = "<",
  eol = "↲",
}

-- Set leader keys before loading plugins and keybindings.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
