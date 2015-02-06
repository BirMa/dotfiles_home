#! /bin/bash
# bash related configuration
#

if [ -f "$HOME/.profile" ]; then
  . $HOME/.profile
fi

# Check for an interactive session
[ -z "$PS1" ] && return

# Do global things
. /home/_gen_/gen.sh

