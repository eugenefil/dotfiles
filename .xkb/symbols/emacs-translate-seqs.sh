#!/bin/bash

# usage: emacs-translate-seqs.sh xkb-symbol-map1 xkb-symbol-map2
#
# Takes two xkb symbol maps (e.g. us-dvorak and ru-jtsuken) and
# outputs emacs lisp code to translate sequences with chars from the
# first to sequences with chars from the second. The goal of
# translation is to have standard sequences (e.g. C-a, C-e, M-f) while
# doing input in a non-English layout. For further details consult
# xsym2char.sh.

./xsym2char.sh <"$1" |
    awk '
{"./xsym2char.sh <'"$2"'" | getline ch2}

/[[:alpha:]]/ {
    s1 = s1 $0
    s2 = s2 ch2
}

END {print s1 "\n" s2}' |
    sed -r -e 's/\\/\\\\/' -e 's/"/\\"/' |
    awk '{
    getline s2
    printf("\
;; generated from %s and %s\n\
(eval-when-compile\n\
  (require '"'"'cl))\n\
(loop\n\
  for from across \"%s\"\n\
  for to   across \"%s\"\n\
  do\n\
  (eval `(define-key key-translation-map\n\
	   (kbd ,(concat \"C-\" (string from)))\n\
	   (kbd ,(concat \"C-\" (string to)))))\n\
  (eval `(define-key key-translation-map\n\
	   (kbd ,(concat \"M-\" (string from)))\n\
	   (kbd ,(concat \"M-\" (string to)))))\n\
  (eval `(define-key key-translation-map\n\
	   (kbd ,(concat \"C-M-\" (string from)))\n\
	   (kbd ,(concat \"C-M-\" (string to))))))\n\
", "'"$1"'", "'"$2"'", $0, s2)
}'
