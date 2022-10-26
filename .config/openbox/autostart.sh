start_xterm() {
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	xterm -e tmux new-session \; new-window cmus \; select-window -t:^
}
start_xterm &
emacs &
firefox &
