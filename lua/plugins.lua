return {
  -- ========================================================================
  -- Editor helpers
  -- ========================================================================
  "folke/neodev.nvim",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },

  -- ========================================================================
  -- UI and navigation
  -- ========================================================================
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = false,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_x = {
          "encoding",
          {
            "fileformat",
            fmt = function(file_format)
              local line_ending_labels = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              }

              return line_ending_labels[file_format] or file_format
            end,
          },
          "filetype",
        },
      },
    },
  },
  { "nvim-tree/nvim-tree.lua", opts = {} },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- ========================================================================
  -- Language server integration
  -- ========================================================================
  { "neovim/nvim-lspconfig" },

  -- ========================================================================
  -- Completion and snippets
  -- ========================================================================
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip", dependencies = { "L3MON4D3/LuaSnip" } },
  { "L3MON4D3/LuaSnip" },

  -- ========================================================================
  -- Language server installation (Mason)
  -- ========================================================================
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

  -- ========================================================================
  -- Formatter installation (Mason)
  -- ========================================================================
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "stylua", "prettier", "ruff" },
      auto_update = false,
    },
  },

  -- ========================================================================
  -- Formatting (Conform)
  -- ========================================================================
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "prettier" },
        jsonc = { "prettier" },
        jsonl = { "jsonl" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        rust = { "rustfmt" },
        go = { "gofmt" },
        python = { "ruff_format" },
      },
      formatters = {
        jsonl = {
          command = "jq",
          args = { "--compact-output", "." },
          stdin = true,
        },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "never", -- Use the configured formatter, not the language server.
      },
    },
  },

  -- ========================================================================
  -- Syntax parsing (Treesitter)
  -- ========================================================================
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
}
