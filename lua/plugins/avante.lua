return {
  "yetone/avante.nvim",
  enabled = false, -- Temporarily disabled.
  event = "VeryLazy",
  version = false,
  build = "OPENSSL_NO_VENDOR=1 PATH=$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH make",
  dependencies = {
    "MunifTanjim/nui.nvim",
    { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
  },
  opts = {
    provider = "local_gemma",
    providers = {
      local_gemma = {
        __inherited_from = "openai",
        endpoint = "http://127.0.0.1:8081/v1",
        model = "gemma-4-E2B-it-Q8_0.gguf",
        api_key_name = "",
        timeout = 120000,
        extra_request_body = { chat_template_kwargs = { enable_thinking = false } },
      },
    },
    behaviour = { auto_suggestions = true },
  },
}
