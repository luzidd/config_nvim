-- Install lazy.nvim if it is missing.
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local filesystem = vim.uv or vim.loop

if not filesystem.fs_stat(lazy_path) then
  local repository_url = "https://github.com/folke/lazy.nvim.git"
  local clone_output = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    repository_url,
    lazy_path,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { clone_output, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Make the installed plugin manager available to require().
vim.opt.rtp:prepend(lazy_path)

-- Load plugin specifications and check for updates.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Use a built-in colorscheme while plugins are being installed.
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
