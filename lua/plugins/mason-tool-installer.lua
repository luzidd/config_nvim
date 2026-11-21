return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  opts = {
    ensure_installed = { "stylua", "prettier", "ruff" },
    auto_update = false,
  },
}
