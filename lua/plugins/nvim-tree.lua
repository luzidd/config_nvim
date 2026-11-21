return {
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
}
