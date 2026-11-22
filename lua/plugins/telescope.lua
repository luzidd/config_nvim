return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local previewers = require("telescope.previewers")
    local preview_utils = require("telescope.previewers.utils")

    return {
      defaults = {
        buffer_previewer_maker = function(filepath, preview_buf, opts)
          opts = opts or {}
          local source_buf = vim.fn.bufnr(vim.fn.fnamemodify(filepath, ":p"))
          if source_buf == -1 or not vim.api.nvim_buf_is_loaded(source_buf) then
            return previewers.buffer_previewer_maker(filepath, preview_buf, opts)
          end

          -- Diagnostics refer to the live buffer, which may have unsaved changes.
          vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, vim.api.nvim_buf_get_lines(source_buf, 0, -1, false))
          if opts.callback then
            opts.callback(preview_buf)
          end
          preview_utils.highlighter(preview_buf, vim.bo[source_buf].filetype, opts)
        end,
      },
    }
  end,
}
