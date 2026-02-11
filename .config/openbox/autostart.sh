start_terminal()
{
	[ -f ~/.Xresources ] && xrdb -l ~/.Xresources
	exec alacritty -e tmux $(pgrep tmux >/dev/null && echo attach)
}

setup_dictation() {
    # Start dotool daemon to handle virtual input
    dotoold &
    # Remove any stale activity flag from previous session
    rm -f /tmp/nerd-dictation-active
    # Ensure Scroll Lock LED is off at login
    xset -led named "Scroll Lock"
}

setup_dictation
start_terminal &

for browser in firefox chromium chromium-browser; do
	if command -v $browser >/dev/null; then
		$browser &
		break
	fi
done
