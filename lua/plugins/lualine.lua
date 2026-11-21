return {
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
}
