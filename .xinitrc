#!/bin/sh
#
# Executed by startx (slim)
#
# like .profile, but only with X-related stuff
#

SESSION_AWESOME="/usr/bin/awesome -c ${HOME}/.config/awesome/rc.lua"
SESSION_XFCE='xfce4-session'

####### debug helper funcs ##################################################
_xinitrc_print_pre() {
  echo -e "xinitrc: pre  ${1}   $2   time: $(date +%s)/$(date)"
}
_xinitrc_print_post() {
  echo -e "xinitrc: post ${1}   $2   pid: $(pidof $1)   time: $(date +%s)/$(date)"
}
#############################################################################


_xinitrc_print_pre


# disable beep (X-style)
xset b 0 &

# set the key repeat rate and delay to my fav-volumes (X-style)
xset r rate 250 30 &

# source .profile (no beeping etc.)
if [ -f "$HOME/.profile" ]; then
  . $HOME/.profile
fi


####### start some useful things before the WM ##############################

# TODO: Why start dbus in .xinitrc?
_xinitrc_print_pre 'dbus_test'
# test for an existing dbus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  ## if not found, launch a new one
  _xinitrc_print_pre 'dbus'
  eval `dbus-launch --exit-with-session --sh-syntax`
  export DBUS_SESSION_BUS_PID
  _xinitrc_print_post 'dbus'
fi
_xinitrc_print_post 'dbus_test'

#_xinitrc_print_pre 'polkit-gnome-authentication-agent-1'
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#_xinitrc_print_post 'polkit-gnome-authentication-agent-1'

#_xinitrc_print_pre 'lxpolkit'
#/usr/lib/lxpolkit/lxpolkit &
#_xinitrc_print_post 'lxpolkit'

#_xinitrc_print_pre 'gnome-keyring-daemon'
#gnome-keyring-daemon --start &
#_xinitrc_print_post 'gnome-keyring-daemon'

#_xinitrc_print_pre 'pulseaudio'
#pulseaudio --start &
#_xinitrc_print_post 'pulseaudio'

_xinitrc_print_pre 'bash' 'devmon'
devmon --sync --exec-on-drive 'notify-send "mount %l" "<b>%f</b> => <b>%d</b>"' --exec-on-unmount 'notify-send "unmount %l" "<b>%f</b> => <b>%d</b>"' --exec-on-remove 'notify-send "remove <b>%f</b>"' &
_xinitrc_print_post 'bash' 'devmon'

#############################################################################

arg_1=$1

# slim keeps messing $1 up; hard code this:
arg_1=awesome

# exec window manager of my choice
case $arg_1 in
  awesome)
    _xinitrc_print_pre 'awesome'
    exec $SESSION_AWESOME
    _xinitrc_print_post 'awesome'
    ;;
  xfce4)
    _xinitrc_print_pre 'xfce4-session'
    exec $SESSION_XFCE
    _xinitrc_print_post 'xfce4-session'
    ;;
  *)
    echo "xinitrc: ERROR: '$arg_1' seems to be nonsense; doing nothing..."
    ;;
esac

