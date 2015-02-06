------------------------------
-- MY Default awesome theme --
------------------------------

G_THEMEDIR = awful.util.getdir("config") .. "/themes/" -- name of this folder
G_THEMENAME = "MY_default"                -- must be the name of the theme's folder
G_T = G_THEMEDIR .. G_THEMENAME .. "/"

theme = {}

theme.font          = "sans 10"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 0
theme.border_normal = "#0c0e10"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = G_T .. "taglist/squarefw.png"
theme.taglist_squares_unsel = G_T .. "taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = G_T .. "submenu.png"
theme.menu_height = 20
theme.menu_width  = 120

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- X icon
theme.titlebar_close_button_normal = G_T .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = G_T .. "titlebar/close_focus.png"

-- star icon
theme.titlebar_ontop_button_normal_inactive = G_T .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = G_T .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = G_T .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = G_T .. "titlebar/ontop_focus_active.png"

-- plus icon
theme.titlebar_sticky_button_normal_inactive = G_T .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = G_T .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = G_T .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = G_T .. "titlebar/sticky_focus_active.png"

-- arrow icon
theme.titlebar_floating_button_normal_inactive = G_T .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = G_T .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = G_T .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = G_T .. "titlebar/floating_focus_active.png"

-- rocet icon
theme.titlebar_maximized_button_normal_inactive = G_T .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = G_T .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = G_T .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = G_T .. "titlebar/maximized_focus_active.png"

-- theme.wallpaper = G_T .. "background.png"

-- You can use your own layout icons like this:
theme.layout_fairh = G_T .. "layouts/fairhw.png"
theme.layout_fairv = G_T .. "layouts/fairvw.png"
theme.layout_floating  = G_T .. "layouts/floatingw.png"
theme.layout_magnifier = G_T .. "layouts/magnifierw.png"
theme.layout_max = G_T .. "layouts/maxw.png"
theme.layout_fullscreen = G_T .. "layouts/fullscreenw.png"
theme.layout_tilebottom = G_T .. "layouts/tilebottomw.png"
theme.layout_tileleft   = G_T .. "layouts/tileleftw.png"
theme.layout_tile = G_T .. "layouts/tilew.png"
theme.layout_tiletop = G_T .. "layouts/tiletopw.png"
theme.layout_spiral  = G_T .. "layouts/spiralw.png"
theme.layout_dwindle = G_T .. "layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
