return {
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
}
