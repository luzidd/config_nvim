return {
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
}
