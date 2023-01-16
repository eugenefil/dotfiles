start_xterm() {
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	if pgrep tmux; then
		exec xterm -e tmux attach
	else
		exec xterm -e tmux new-session \; new-window cmus \; select-window -t:^
	fi
}
start_xterm &
chromium-browser &
