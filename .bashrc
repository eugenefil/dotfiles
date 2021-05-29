# if not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# don't put duplicate lines in history
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTFILESIZE=10000 HISTSIZE=10000

export EDITOR=vim
PS1='\$ '

# add path to my bin/ to PATH
PATH=~/bin:$PATH
# add path to executable gems to PATH
which ruby &>/dev/null && PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

shopt -s globstar autocd

alias l='ls -al --color=auto'
alias l1='ls -1 --color=auto'
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias udiff='diff -u --color=auto'
alias pu=pushd
alias po=popd
alias ds=dirs
alias md=mkdir
alias rmr='rm -r'
alias rmrf='rm -rf'

mdcd() { mkdir "$@" && { for dir; do :; done; cd "$dir"; } }

playalarm() { local n; n="${1:-1}"; while ((n--)); do aplay -q ~/alarm.wav; sleep 1s; done; }
loopalarm() { local n; n="${1:-1000}"; while ((n--)); do playalarm 5; sleep 1m; done; }
alarm() { ts=`date -d "$1" +%s`; while [ `date +%s` -lt $ts ]; do sleep 1m; done; loopalarm 5; }
countdown() { sleep "$@" && loopalarm 5; }
