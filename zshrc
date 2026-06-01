HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# aliases
alias lls='ls -ltr'
alias ll='ls -l'
alias k='kubectl'
alias tmux='tmux -u'
alias tmat='tmux new-session -ADs main'

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

autoload -U select-word-style
select-word-style bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


. "$HOME/.local/bin/env"
