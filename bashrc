# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export TERM=xterm-256color
export PAGER=less
export LESS="-X -R"
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# aliases
alias rebash='source ~/.bashrc'
alias lls='ls -ltr'
alias xcat='xmllint --format'
alias lls="ls -ltr"
alias l="less"
alias listd="ls -ltr | grep ^d"
alias igrep="grep -i"
alias llo="lsof +d ."
alias pysmp="python -m SimpleHTTPServer"
alias tmat="tmux attach"
alias giturl="git remote set-url origin"
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias agp='ack-grep --passthru'
alias hg='history | grep'
alias pe='perl -pe'
alias ipe='perl -i -pe'
alias fargs="find . -type f | xargs"

xless() { xmllint --format $1 | less ; }
wless() { cut -c -$COLUMNS $1 | less; }
pshere() { ps -fp $(pwdx $(ps -e | awk '{print $1}' | grep -v PID ) 2>/dev/null | grep $PWD | cut -d: -f1 | tr '\n' , | perl -pe "s#(.*),#\1#"); }
pss() { ps -fu $(whoami); }
fp() { dir=${2:-.}; find ${dir} -name "*$1*"; }
ac() { awk '{print $COL}' COL=$1; }

# marks
jump() {
    [ -z "$1" ] && echo "mark name missing" && return 1
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
mark() {
    [ -z "$1" ] && echo "mark name missing" && return 1
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
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
    local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}
export MARKPATH=${HOME}/.marks
mkdir -p ${MARKPATH}
complete -F _completemarks jump unmark

PROMPT_COMMAND='echo -ne "\033]0;`hostname`:  ${PWD} - `$WHOAMI` \007"'

if command -v kubectl; then
    source <(kubectl completion bash)
    alias k=kubectl
    complete -F __start_kubectl k
fi
