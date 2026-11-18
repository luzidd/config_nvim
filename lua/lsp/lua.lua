vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  -- Prefer a Lua project config; otherwise use the Git root.
  -- The two Lua config filenames have equal priority.
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  -- Neovim runs Lua code with LuaJIT.
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        -- Provide core Neovim types before lazydev adds plugin libraries.
        library = { vim.env.VIMRUNTIME .. "/lua" },
      },
    },
  },
}

vim.lsp.enable("lua_ls")
