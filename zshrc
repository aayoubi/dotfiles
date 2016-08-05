HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# aliases
alias lls='ls -ltr'

# compinstall
zstyle :compinstall filename '/home/aayoubi/.zshrc'
autoload -Uz compinit
compinit
