-- Set editor options and leader keys before loading plugins.
require("config.options")

-- Register keybindings after setting the leader keys.
require("config.keymaps")

-- Bootstrap lazy.nvim, the plugin manager that installs, loads, and updates plugins.
require("config.lazy")

-- Configure and enable language servers.
require("config.lsp")

-- Configure completion and snippet expansion.
require("config.cmp")
