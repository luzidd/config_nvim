local project_markers = { "Cargo.toml", "rust-project.json" }
local default_root_dir = vim.lsp.config.rust_analyzer.root_dir

-- A Git root alone is not a Rust project.
vim.lsp.config("rust_analyzer", {
  root_dir = function(bufnr, on_dir)
    local project_root = vim.fs.root(bufnr, project_markers)
    if not project_root then
      return
    end

    -- Preserve lspconfig's Cargo workspace detection when available.
    if type(default_root_dir) == "function" then
      default_root_dir(bufnr, on_dir)
    else
      on_dir(project_root)
    end
  end,
})

vim.lsp.enable("rust_analyzer")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("RustStandaloneLsp", { clear = true }),
  pattern = "rust",
  callback = function(event)
    local filename = vim.api.nvim_buf_get_name(event.buf)
    if filename == "" or vim.bo[event.buf].buftype ~= "" or vim.fs.root(event.buf, project_markers) then
      return
    end

    -- Reuse capabilities, command, and initialization hooks from lspconfig.
    local config = vim.deepcopy(assert(vim.lsp.config.rust_analyzer))
    config.name = "rust_analyzer_standalone"
    config.root_dir = nil
    config.root_markers = nil
    config.workspace_folders = nil
    config.workspace_required = false
    -- lspconfig's before_init passes these settings as initializationOptions.
    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      ["rust-analyzer"] = { detachedFiles = { filename } },
    })

    vim.lsp.start(config, {
      bufnr = event.buf,
      reuse_client = function(client)
        local files = vim.tbl_get(client.config, "settings", "rust-analyzer", "detachedFiles")
        return client.name == config.name and files ~= nil and files[1] == filename
      end,
    })
  end,
})
