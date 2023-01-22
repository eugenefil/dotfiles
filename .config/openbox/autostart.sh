start_xterm()
{
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	exec xterm -e tmux $(pgrep tmux >/dev/null && echo attach)
}
start_xterm &
chromium-browser &
