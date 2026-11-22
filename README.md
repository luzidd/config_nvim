# Neovim configuration

Plugins: [lazy.nvim](https://github.com/folke/lazy.nvim).

Language servers: [Mason](https://github.com/mason-org/mason.nvim).

## Requirements

- Neovim 0.11+ and Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) for text search
- Server-specific tools, such as Node.js and npm for TypeScript
- [mise](https://mise.jdx.dev/) for formatting (optional)

First startup installs plugins and configures Mason to install Lua, Bash, Python, TypeScript/JavaScript, Rust, Go, and JSON servers.

## Keybindings

Leader: **Space**. Press keys in sequence in normal mode.

| Keys | Action |
| --- | --- |
| `gd` | Go to definition |
| `gl` | Show line diagnostics |
| `Space d` | Diagnostic overview for the current file |
| `Space e` | Toggle file tree |
| `Space o` | Toggle heading / code outline |
| `Space f f` | Find files |
| `Space f g` | Search text |
| `Space f b` | Find buffers |
| `Space l` | Open lazy.nvim |
| `Space m` | Open Mason |

In insert mode, Tab and Shift-Tab navigate completion suggestions; Enter confirms the selection.

## Local AI completion

[llama.vim](https://github.com/ggml-org/llama.vim) requests inline suggestions from llama-server at `http://127.0.0.1:8080/infill` (requires `curl` and a running FIM-capable model).

In insert mode: **Alt-a** accepts a suggestion; **Alt-f** requests one manually. Tab remains reserved for nvim-cmp. Toggle automatic suggestions with `:LlamaToggleAutoFim`.

The current file's context is sent to the local server; extra context from other buffers and yanks is disabled.

## Outline

`Space o` opens [Aerial](https://github.com/stevearc/aerial.nvim) on the right. Select a heading or symbol and press Enter to jump.

Markdown works without extra tools. Other languages need a compatible Treesitter parser or an attached LSP server with document-symbol support.

## Git

[Gitsigns](https://github.com/lewis6991/gitsigns.nvim) adds gutter markers and buffer-local shortcuts in Git-tracked files.

| Keys | Action |
| --- | --- |
| `]c` / `[c` | Next / previous change |
| `Space g p` | Preview change |
| `Space g b` | Blame current line |

Gutter: `+` added, `~` changed, `_` deleted below, `-` deleted above the first line. `~` also marks changed-and-deleted lines; `?` marks untracked lines when attached.

File tree Git markers:

| Marker | Status |
| --- | --- |
| `M` / `S` | Unstaged / staged |
| `?` / `I` | Untracked / ignored |
| `!` | Conflict |
| `R` / `D` | Renamed / deleted |

## Formatting

Run `mise install` once, then:

```sh
mise run fmt        # Format Lua files
mise run fmt-check  # Check formatting
```
