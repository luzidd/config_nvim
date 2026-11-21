return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- Load libuv types only when a file uses vim.uv.
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}
