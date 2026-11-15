# Neovim configuration

Plugins: [lazy.nvim](https://github.com/folke/lazy.nvim). Language servers: [Mason](https://github.com/mason-org/mason.nvim).

## Requirements

- Neovim 0.11+ and Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) for text search
- Server-specific tools, such as Node.js and npm for TypeScript
- [mise](https://mise.jdx.dev/) for formatting (optional)

First startup installs plugins and configures Mason to install Lua, Python, TypeScript/JavaScript, Rust, Go, and JSON servers.

## Keybindings

Leader: **Space**. Press keys in sequence in normal mode.

| Keys | Action |
| --- | --- |
| `gd` | Go to definition |
| `Space e` | Toggle file tree |
| `Space f f` | Find files |
| `Space f g` | Search text |
| `Space f b` | Find buffers |
| `Space l` | Open lazy.nvim |
| `Space m` | Open Mason |

In insert mode, Tab and Shift-Tab navigate completion suggestions; Enter confirms the selection.

## Formatting

Run `mise install` once, then:

```sh
mise run fmt        # Format Lua files
mise run fmt-check  # Check formatting
```
