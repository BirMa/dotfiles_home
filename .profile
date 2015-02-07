#! /bin/bash
# global configration, tweaks, ...
#

[ -n "$PROFILE_DEFINED" ] && return
export PROFILE_DEFINED="1"

# set PATH so it include my private bins if they exist
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/share/adt-bundle-linux-x86_64/sdk/platform-tools/" ] ; then
  PATH="$PATH:$HOME/share/adt-bundle-linux-x86_64/sdk/platform-tools/"
fi

if [ -d "$HOME/share/adt-bundle-linux-x86_64/sdk/tools/" ] ; then
  PATH="$PATH:$HOME/share/adt-bundle-linux-x86_64/sdk/tools/"
fi

# disable beep (console-style)
setterm -blength 0

