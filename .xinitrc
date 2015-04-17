#!/bin/sh
#
# Executed by startx (i.e. slim)
#

####### debug helper funcs ##################################################
_xinitrc_print_pre() {
  echo -e "xinitrc: pre  ${1}   $2   time: $(date +%s)/$(date)"
}
_xinitrc_print_post() {
  echo -e "xinitrc: post ${1}   $2   pid: $(pidof $1)   time: $(date +%s)/$(date)"
}
#############################################################################


_xinitrc_print_pre


_xinitrc_print_pre 'etc_xinitrc.d'
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
_xinitrc_print_post 'etc_xinitrc.d'


# disable beep (X-style)
xset b 0 &

# set the key repeat rate and delay to my fav-volumes (X-style)
xset r rate 250 30 &

# Prepend my personal font folders to Xorg's list of known font paths
xset +fp "$XDG_DATA_HOME/fonts/truetype"
xset +fp "$XDG_DATA_HOME/fonts/type1"

# source .profile not necessary without graphical login manager
#if [ -f "$HOME/.profile" ]; then
#  . $HOME/.profile
#fi


####### start some useful things before the WM ##############################

_xinitrc_print_pre 'bash' 'devmon'
devmon --sync --exec-on-drive 'notify-send "mount %l" "<b>%f</b> => <b>%d</b>"' --exec-on-unmount 'notify-send "unmount %l" "<b>%f</b> => <b>%d</b>"' --exec-on-remove 'notify-send "remove <b>%f</b>"' &
_xinitrc_print_post 'bash' 'devmon'

#############################################################################


session=${1:-awesome}

_xinitrc_print_pre 'WM'
case $session in
    awesome           ) exec "awesome";;
    bspwm             ) exec "bspwm";;
    catwm             ) exec "catwm";;
    cinnamon          ) exec "cinnamon-session";;
    dwm               ) exec "dwm";;
    enlightenment     ) exec "enlightenment_start";;
    ede               ) exec "startede";;
    fluxbox           ) exec "startfluxbox";;
    gnome             ) exec "gnome-session";;
    gnome-classic     ) exec "gnome-session --session=gnome-classic";;
    i3|i3wm           ) exec "i3";;
    icewm             ) exec "icewm-session";;
    jwm               ) exec "jwm";;
    kde               ) exec "startkde";;
    mate              ) exec "mate-session";;
    monster|monsterwm ) exec "monsterwm";;
    notion            ) exec "notion";;
    openbox           ) exec "openbox-session";;
    unity             ) exec "unity";;
    xfce|xfce4        ) exec "xfce4-session";;
    xmonad            ) exec "xmonad";;
    *)
    echo "xinitrc: ERROR: '$arg_1' seems to be nonsense; lets try running it as a command! ..."
    exec $1
    ;;
esac

# We'll get here in case of error.
_xinitrc_print_post 'WM'
