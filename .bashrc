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

# Start x when not on X.
if [[ -z $DISPLAY ]]; then
  if [ $(yesNoQ --default yes --timeout 5 'startx [Y|n] ? ';echo $?) -eq 0 ]; then
    echo -e 'starting X...\n'
    startx
  fi
fi
