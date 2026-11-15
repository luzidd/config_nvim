return {
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

 -- UI
  { "nvim-lualine/lualine.nvim", opts = {} },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP & Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Mason LSP Manager
  { "mason-org/mason.nvim", opts = {} },
  {
      "mason-org/mason-lspconfig.nvim",
      dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
      opts = {
          automatic_enable = false,
          ensure_installed = {
              "lua_ls",
              "pyright",
              "ts_ls",
              "rust_analyzer",
              "gopls",
              "jsonls",
          },
      },
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

}
