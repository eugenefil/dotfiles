start_xterm() {
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	if pgrep tmux; then
		xterm -e tmux attach
	else
		xterm -e tmux new-session \; new-window cmus \; select-window -t:^
	fi
}
start_xterm &
emacs &
firefox &
