# ── History ──────────────────────────────────────────────────────────────────

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# ── ZSH options ──────────────────────────────────────────────────────────────

bindkey -e

zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit
autoload -U select-word-style && select-word-style bash

# ── ZSH-specific aliases ──────────────────────────────────────────────────────

alias tmux='tmux -u'

# ── pyenv ────────────────────────────────────────────────────────────────────

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ── Shared ───────────────────────────────────────────────────────────────────

. ~/.shellrc
