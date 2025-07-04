# if not running interactively, don't do anything
[[ "$-" != *i* ]] && return

set +H

# don't put duplicate lines in history
HISTCONTROL=erasedups
HISTFILESIZE=10000
HISTSIZE=10000
shopt -s histappend

export EDITOR=vim
PS1='${?#0}\$ '

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

shopt -s globstar autocd

alias l='ls -al --color=auto'
alias l1='ls -1 --color=auto'

alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias bgrep='LANG=C grep -aboP'

alias elfh='readelf -Wh'
alias elfS='readelf -WS'
alias elfs='readelf -Ws'
alias elfr='readelf -Wr'
alias elfl='readelf -Wl'
alias elfd='readelf -Wd'
alias elfp='readelf -Wp'
alias elfx='readelf -Wx'
alias elfa='readelf -Wa'
alias disas='objdump -d'
alias disarm='objdump -D -b binary -m armv7'

alias hex='printf "%x\n"'
alias dec='printf "%d\n"'

alias udiff='diff -u --color=auto'

alias pu=pushd
alias po=popd
alias ds=dirs

alias md=mkdir
alias rmr='rm -r'
alias rmrf='rm -rf'

alias apkl='apk info -L'
alias apki='apk info'

alias hx=helix

mdcd() { mkdir "$@" && { for dir; do :; done; cd "$dir"; } }

fncat() { for f; do echo "$f":; cat "$f"; done }

vimsession() { vim -S ~/.vim/session/"$1".session -i ~/.vim/session/"$1".viminfo; }
