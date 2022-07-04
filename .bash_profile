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

    # if virt console <= 2, start X, unless any key pressed
    if [[ $XDG_VTNR -le 2 && -z "$DISPLAY" ]]; then
	read -t1 -N1 -rsp 'Starting X in 1 sec. Press any key to abort... ' ||
	    exec startx
	echo
    fi
fi
