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

# see more at: https://github.com/woegjiub/.config/blob/master/bash/xdg.sh
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export VIMPERATOR_RUNTIME="$XDG_CONFIG_HOME/vimperator"
export VIMPERATOR_INIT=":source $VIMPERATOR_RUNTIME/vimperatorrc"

export PENTADACTYL_RUNTIME="$XDG_CONFIG_HOME/pentadactyl"
export PENTADACTYL_INIT=":source $PENTADACTYL_RUNTIME/pentadactylrc"

export RXVT_SOCKET="$XDG_DATA_HOME/urxvt/urxvt-$HOST"

#export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

export GEM_HOME="$HOME/.local/lib/gems"
export GEM_PATH="$HOME/.local/bin"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export GSTREGISTRY="$XDG_DATA_HOME/gstreamer/registry.bin"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export HISTFILE="$XDG_DATA_HOME/bash/history"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

export PYLINTHOME="$XDG_DATA_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

export KDEHOME="$XDG_CONFIG_HOME/kde"

export LESSHISTFILE="$XDG_DATA_HOME/less/history"

export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"

#export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"

export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
export PIP_LOG_FILE="$XDG_DATA_HOME/pip/log"

#export TERMINFO="$XDG_CONFIG_HOME/terminfo"

export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"

#export XAUTHORITY="$XDG_DATA_HOME/Xauthority"



# disable beep (console-style)
setterm -blength 0

