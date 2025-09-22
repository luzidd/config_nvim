vim.lsp.config["gopls"] = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
        },
    },
}

vim.lsp.enable("gopls")
