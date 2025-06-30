start_terminal()
{
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	exec alacritty -e tmux $(pgrep tmux >/dev/null && echo attach)
}
start_terminal &

for browser in chromium chromium-browser; do
	if command -v $browser >/dev/null; then
		$browser &
		break
	fi
done
