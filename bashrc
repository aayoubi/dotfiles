# Non-interactive: bail out
case $- in
  *i*) ;;
  *) return ;;
esac

# ── History ──────────────────────────────────────────────────────────────────

export HISTTIMEFORMAT='%F %T '
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

# ── Colors ───────────────────────────────────────────────────────────────────

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ── Bash-specific aliases ─────────────────────────────────────────────────────

alias rebash='source ~/.bashrc'

# ── Marks ────────────────────────────────────────────────────────────────────

export MARKPATH="${HOME}/.marks"
mkdir -p "${MARKPATH}"

jump() {
  [ -z "$1" ] && echo "mark name missing" && return 1
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
mark() {
  [ -z "$1" ] && echo "mark name missing" && return 1
  mkdir -p "$MARKPATH"
  ln -s "$(pwd)" "$MARKPATH/$1"
}
unmark() {
  [ -z "$1" ] && echo "mark name missing" && return 1
  rm -i "$MARKPATH/$1"
}
marks() {
  ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist
  wordlist=$(find "$MARKPATH" -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
}
complete -F _completemarks jump unmark

# ── Prompt ───────────────────────────────────────────────────────────────────

PROMPT_COMMAND='echo -ne "\033]0;$(hostname):  ${PWD} - ${USER} \007"'

# ── Shared ───────────────────────────────────────────────────────────────────

. ~/.shellrc
