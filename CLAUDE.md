# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles managed via symlinks. The Makefile installs symlinks from this repo into `~`.

## Deploying

```bash
make sync    # create symlinks (skips if target already exists)
make clean   # remove all managed symlinks
make         # clean then sync
make pre     # install vim-plug (needed before first vim use)
```

Symlink targets:
| File | Destination |
|------|-------------|
| `bashrc` | `~/.bashrc` |
| `zshrc` | `~/.zshrc` |
| `shellrc` | `~/.shellrc` |
| `vimrc` | `~/.vimrc` |
| `init.lua` | `~/.config/nvim/init.lua` |
| `tmuxconf` | `~/.tmux.conf` |
| `gitconfig` | `~/.gitconfig` |

`tmux/plugins/tpm` is a git submodule — run `git submodule update --init` after cloning.

## Architecture

### Shell configs (`bashrc`, `zshrc`, `shellrc`)
Common config lives in `shellrc` (sourced by both shells at the end): PATH setup (Go, pnpm, nvim), shared aliases and functions, NVM, conda, uv, kubectl completion, and fzf. Shell detection uses `_shell="${BASH_VERSION:+bash}${ZSH_VERSION:+zsh}"` so completions and hooks are invoked with the right shell name.

`bashrc` adds: history options, dircolors, the marks bookmark system (`mark`/`jump`/`unmark`/`marks`) backed by symlinks in `~/.marks`, and `PROMPT_COMMAND` for terminal title.

`zshrc` adds: compinit, bindkey, select-word-style, `alias tmux='tmux -u'`, and pyenv. Both use `tmat` as the canonical alias for attaching/creating a persistent tmux session named `main`.

### Neovim (`init.lua`)
Uses `lazy.nvim` as the plugin manager (auto-bootstrapped). Key plugins:
- **Telescope** — fuzzy finder; `<leader>sf` files, `<leader>sg` live grep, `<leader>/` buffer search
- **nvim-lspconfig + Mason** — LSP with auto-install; `gd` go-to-def, `gr` references, `<leader>ca` code action, `<leader>rn` rename
- **nvim-cmp** — completion (LSP + snippets via LuaSnip)
- **conform.nvim** — auto-format on save
- **gitsigns** — inline git hunks
- **which-key** — keybind discovery popup

Leader is `<Space>`. Common custom maps: `jj` → Esc in insert mode, `<leader>w` save, `<leader>q` force quit, `<leader>z` save-and-quit, `<leader>n`/`<leader>N` next/prev buffer, `<C-h/j/k/l>` window navigation.

### Vim (`vimrc`)
Lighter config using vim-plug. Same `jj`/`<leader>w/q/z/n/N` keybinds as Neovim. Go development via `vim-go` (`<leader>b/r/t` for build/run/test). Colorscheme: catppuccin_mocha.

### Tmux (`tmuxconf`)
Prefix is `C-s`. Window navigation: `h`/`l`. Pane navigation: `j`/`k`. Uses TPM with: tmux-resurrect, tmux-continuum, dracula theme (weather for Paris, 24h clock). Mouse support enabled.

### Git (`gitconfig`)
Aliases: `co`, `com`, `st` (status -sb), `lg` (oneline), `hist` (graph log). Default editor: nvim. Default branch: main.
