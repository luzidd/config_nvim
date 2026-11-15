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
  { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
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

  -- Install shared formatter binaries in Mason's data directory.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "stylua", "prettier", "ruff" },
      auto_update = false,
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "prettier" },
        jsonc = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        python = { "ruff_format" },
      },
      format_on_save = { timeout_ms = 2000, lsp_format = "never" },
    },
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}
