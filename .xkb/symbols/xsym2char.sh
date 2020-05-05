#!/bin/bash

# usage: $0 <xkb-symbol-map
#
# Converts an `xkb-symbol-map' on stdin to a string of chars on
# stdout, each char corresponding to a symbol found in the map. The
# map is assumed two-level with entries of the format:
#
#  key <XXXX> {[Symbol1, Symbol2]};
#
# You may need to install x11proto-core-dev package to get
# keysymdef.h.

# sed `-u' (unbuffered) prevents hanging when called from gawk
sed -unr 's/^\s+key\s<.+>\s\{\[(.+),\s(.+)\]\};$/XK_\1\nXK_\2/p' |
    xargs -i grep '#define\s{}\s' /usr/include/X11/keysymdef.h |
    sed -unr 's_^.+/\* U\+(....).+$_\1_p' |
    xargs -i python3 -c "print('\u{}')"
