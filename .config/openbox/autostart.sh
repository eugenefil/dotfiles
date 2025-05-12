start_terminal()
{
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	exec alacritty -e tmux $(pgrep tmux >/dev/null && echo attach)
}
start_terminal &
chromium-browser &
