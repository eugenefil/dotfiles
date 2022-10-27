[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

[ -z "$TMUX" ] && {
	PATH=~/bin:~/.local/bin:$PATH

	[ -d "$HOME/.bash_profile.d" ] && {
		for f in "$HOME/.bash_profile.d"/*; do
			[ -x "$f" ] && "$f"
		done
	}
}

if [ -z "$SSH_CONNECTION" ]; then
	tput cvvis # block cursor mode
	clear # clear screen

	# start X, unless any key pressed
	if [ -z "$DISPLAY" ]; then
		read -t1 -N1 -rsp 'starting X, press key to abort...' || {
			# Note, WM must be started in background as
			# below and xorg must replace login shell, not
			# vice versa. This way login process waits for
			# xorg to terminate before dying itself and
			# invoking tty hangup, so xorg can revert tty
			# back to text mode before hangup occurs.
			# Otherwise, if WM replaces login shell and
			# becomes the process which login waits for,
			# it dies right after xorg closes its socket
			# thus leading to tty hangup, so xorg can't
			# revert hung-up tty leaving it in graphics
			# mode unusable by new getty instance.
			(sleep 1; DISPLAY=:0 exec ~/.xinitrc) &

			# Run raw Xorg skipping startx, xinit,
			# Xorg.wrap. No cookie auth is used, b/c we're
			# the only user. End session via `pkill Xorg`.
			exec /usr/libexec/Xorg -nolisten tcp :0 vt1 -keeptty
		}
		echo
	fi
fi
