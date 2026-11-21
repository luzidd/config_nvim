return {
  "ggml-org/llama.vim",
  enabled = false, -- Temporarily disabled.
  init = function()
    vim.g.llama_config = {
      endpoint_fim = "http://127.0.0.1:8080/infill",
      auto_fim = false, -- Avante handles automatic suggestions; Alt-f still triggers llama.vim.
      -- Allow longer suggestions on slower local models.
      t_max_predict_ms = 10000, -- Follow-up requests; the plugin caps the first at 250 ms.
      n_predict = 256,
      show_info = false,
      ring_n_chunks = 0, -- Do not send extra context from other buffers or yanks.

      -- Keep Tab and Shift-Tab available for nvim-cmp.
      keymap_fim_trigger = "<M-f>",
      keymap_fim_accept_full = "<M-a>",
      keymap_fim_accept_line = "",
      keymap_fim_accept_word = "",
      keymap_fim_next = "",
      keymap_fim_prev = "",

      -- This integration is completion-only; preserve other editing keys.
      keymap_inst_trigger = "",
      keymap_inst_rerun = "",
      keymap_inst_continue = "",
      keymap_inst_accept = "",
      keymap_inst_cancel = "",
      keymap_debug_toggle = "",
    }
  end,
}
