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
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        highlight_git = "none", -- Keep filename colors unchanged.
        icons = {
          git_placement = "signcolumn",
          symlink_arrow = " -> ",
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = true,
            modified = false,
            hidden = false,
            diagnostics = false,
            bookmarks = false,
          },
          glyphs = {
            folder = { arrow_closed = ">", arrow_open = "v" },
            git = {
              unstaged = "M",
              staged = "S",
              unmerged = "!",
              renamed = "R",
              untracked = "?",
              deleted = "D",
              ignored = "I",
            },
          },
        },
      },
    },
    config = function(_, options)
      require("nvim-tree").setup(options)

      local function highlight_git_markers()
        local colors = {
          NvimTreeGitDirtyIcon = "#e5c07b", -- Modified: yellow
          NvimTreeGitStagedIcon = "#98c379", -- Staged: green
          NvimTreeGitNewIcon = "#61afef", -- Untracked: blue
          NvimTreeGitRenamedIcon = "#56b6c2", -- Renamed: cyan
          NvimTreeGitDeletedIcon = "#e06c75", -- Deleted: red
          NvimTreeGitMergeIcon = "#e06c75", -- Conflict: red
          NvimTreeGitIgnoredIcon = "#7f848e", -- Ignored: gray
        }

        for group, color in pairs(colors) do
          vim.api.nvim_set_hl(0, group, { fg = color })
        end
      end

      -- Reapply marker colors when switching colorschemes.
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("TreeGitColors", { clear = true }),
        callback = highlight_git_markers,
      })
      highlight_git_markers()
    end,
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "AerialToggle", "AerialOpen", "AerialClose" },
    opts = {
      -- Markdown headings need no server; code uses Treesitter or LSP symbols.
      backends = { "treesitter", "lsp", "markdown" },
      layout = { default_direction = "right" },
      nerd_font = false,
      icons = { Interface = "#" },
    },
  },

  -- ========================================================================
  -- Git changes
  -- ========================================================================
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- ASCII gutter markers; no special font required.
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },
      signs_staged_enable = false,

      -- Keep Git shortcuts local to attached buffers.
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")

        -- Preserve native change navigation in diff windows.
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { buffer = buffer, desc = "Next Git change" })

        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { buffer = buffer, desc = "Previous Git change" })

        -- Inspect changes without modifying the Git index.
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = buffer, desc = "Preview Git change" })
        vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, { buffer = buffer, desc = "Git blame line" })
      end,
    },
  },

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
        "bashls",
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
