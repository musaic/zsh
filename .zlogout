#!/usr/bin/env zsh
#
# vim:ft=zsh
#
# zlogout- Runs on logout (i.e., you're running a a login shell like 'zsh -l')

# Clear out screen buf on real terminals, cleansup tmp files

[[ $MYDEBUG -ge 1 ]] && print '[zlogout]'

clear
srm -rf "$TMPDIR"

export ZLOGOUT_DONE=1
