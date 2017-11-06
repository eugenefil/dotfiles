#!/bin/bash

# usage: $0 non-us-map us-map
#
# Join non-us-map and us-map, so that for each corresponding keycode
# us-map symbols are appended to the end of the tuple of non-us-map
# symbols. Assumes two-level maps. This is used to generate a combined
# map, where level 1 and 2 represent non-US layout, while level 3 and
# 4 hold corresponding US symbols and are used in Control/Alt combos.

NON_US_MAP=$1
US_MAP=$2
echo // generated from "$NON_US_MAP" and "$US_MAP"
gawk -v "US_MAP=$US_MAP" <"$NON_US_MAP" '
/key </ {
    cmd = "./xsym2char.sh"
    print |& cmd
    cmd |& getline sym_non_us
    cmd |& getline foo # empty the buffer to prevent error
    close(cmd)
    type = sym_non_us ~ /[[:alpha:]]/ ? \
        "ALPHABETIC_WITH_CTRL_ALT_COMBOS" : \
        "TWO_LEVEL_WITH_CTRL_ALT_COMBOS"

    # read symbols from us-map
    cmd = "sed -rn \"s/^\\s*key\\s+<.+>\\s+\\{\\[(.+)\\].+$/\\1/p\" " \
        US_MAP
    cmd | getline syms_us

    def = "{\n\
        type[Group1] = \"%s\",\n\
        symbols[Group1] = [\\1, %s]\n\
    }"
    print gensub(/\{\[(.+)\]\}/, sprintf(def, type, syms_us), 1)
    next
}

1'
