-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- widgets
local vicious = require("vicious")


-- {{{ Helper functions

local client_tag_moveRight  = function ()
  local new_tag = awful.tag.getidx(awful.tag.selected())
  
  if new_tag > tag_count-1 then
    new_tag = 0
  end
  awful.client.movetotag(tags[client.focus.screen][ (new_tag) % tag_count+1 ])
  awful.tag.viewnext()
end

local client_tag_moveLeft = function ()
  local new_tag = awful.tag.getidx(awful.tag.selected()) - 2
  
  if new_tag < 0 then
    new_tag = tag_count-1
  end
  awful.client.movetotag(tags[client.focus.screen][ (new_tag) % tag_count+1 ])
  awful.tag.viewprev()
end

function echo (arg, title)
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = title,
    text=tostring(arg)
  })
end

-- Helper functions }}}


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Error during startup",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Error occurred",
    text = err .. "\n\n" .. debug.traceback() })
    in_error = false
  end)
end
-- Error handling }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/MY_default/theme.lua")

-- Application launches
terminal_cmd = "urxvtc"
terminal_root_cmd = "gksu urxvt"
filemanager1_cmd = "thunar"
filemanager1_root_cmd = "gksu thunar"
filemanager2_cmd = "spacefm"
filemanager2_root_cmd = "gksu spacefm"
editor_cmd = "gvim"
editor_root_cmd = "gksu gvim"

-- Tool launches
maxBrightness_cmd = "maxBrightness"
minBrightness_cmd = "minBrightness"
kbd_switch2_de_cmd = "setxkbmap -layout de"
kbd_switch2_us_cmd = "setxkbmap -layout us -variant altgr-intl"
eject_cmd = "eject -T"
killallFlash_cmd = "killall plugin-container"
killallFirefox_cmd = "killall firefox"

lock_screen_cmd = "slimlock"

suspend_disk_cmd = "suspend_disk"
suspend_ram_cmd = "suspend_ram"
shutdown_cmd = "systemctl poweroff"
reboot_cmd  = "systemctl reboot"

etc_shutdown_cmd = "etc_shutdown"
lock_suspend_disk_cmd = "suspend_disk l"
lock_suspend_ram_cmd = "suspend_ram l"

notifySendWmNameAndWmClass_cmd = "notifySendWmNameAndWmClass"


-- overwrite naugty settings:
--naughty.config.default_preset.timeout          = 5
--naughty.config.default_preset.screen           = 1
--naughty.config.default_preset.position         = "top_right"
--naughty.config.default_preset.margin           = 4
--naughty.config.default_preset.height           = 32
--naughty.config.default_preset.width            = 300
--naughty.config.default_preset.gap              = 1
--naughty.config.default_preset.ontop            = true
--naughty.config.default_preset.font             = beautiful.font or "Verdana 8"
--naughty.config.default_preset.icon             = nil
--naughty.config.default_preset.icon_size        = 32
--naughty.config.default_preset.fg               = beautiful.fg_focus or '#ffffff'
--naughty.config.default_preset.bg               = beautiful.bg_focus or '#535d6c'
--naughty.config.presets.normal.border_color     = beautiful.border_focus or '#535d6c'
--naughty.config.default_preset.border_width     = 1
--naughty.config.default_preset.hover_timeout    = nil


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.magnifier,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.spiral,
  --awful.layout.suit.fair.horizontal,
  --awful.layout.suit.fair,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile,
  --awful.layout.suit.grid,
}
-- Variable definitions }}}


-- {{{ Wallpaper
if beautiful.wallpaper then
  for s = 1, screen.count() do
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
  end
end
-- Wallpaper }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.

tags = {}
tagnames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 'a', 'b', 'c', }
tag_count = #tagnames

for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = awful.tag(tagnames, s, layouts[1])
end
-- Tags }}}

-- {{{ Menu

awful.menu.menu_keys = {
  up    = { "k", "Up" },
  down  = { "j", "Down" },
  exec  = { "l", "Return", "Right" },
  enter = { "l", "Right" },
  back  = { "h", "Left" },
  close = { "q", "Escape" },
}

-- Create a laucher widget and a main menu
myawesomemenu = {
  { "manual", terminal_cmd .. " -e man awesome" },
  { "restart", awesome.restart },
  { "quit", awesome.quit },
}

mytoolsmenu = {
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "wm info", notifySendWmNameAndWmClass_cmd },
  { "max brightness", maxBrightness_cmd },
  { "min brightness", minBrightness_cmd },
}

myplusmenu = {
  { "etc,shutdown", etc_shutdown_cmd },
  { "lock,hibernate", lock_suspend_disk_cmd },
  { "lock,suspend", lock_suspend_ram_cmd },
}

mymainmenu = awful.menu ({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "tools", mytoolsmenu },
    { "+", myplusmenu },
    { "hibernate", suspend_disk_cmd },
    { "suspend", suspend_ram_cmd },
    { "shutdown", shutdown_cmd },
    { "reboot", reboot_cmd },
  }
})

--mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
-- Menu }}}

-- {{{ Wibox

-- volume change
volume = {}
volume.isMute = false
volume.ALSAcardid = 1
volume.ALSAchanMaster = "Master"
volume.PAsinkName = "alsa_output.pci-0000_00_1b.0.analog-stereo"

volume.up = function ()
  fd = io.popen("amixer -c " .. volume.ALSAcardid .. " sset " .. volume.ALSAchanMaster .. " 1%+")
  fd:close()
end

volume.down = function ()
  fd = io.popen("amixer -c " .. volume.ALSAcardid .. " sset " .. volume.ALSAchanMaster .. " 1%-")
  fd:close()
end

volume.toggleMute = function ()
  if volume.isMute then
    fd = io.popen("pacmd set-sink-mute " .. volume.PAsinkName .. " false")
    fd:close()
    volume.isMute = false
  else
    fd = io.popen("pacmd set-sink-mute " .. volume.PAsinkName .. " true")
    fd:close()
    volume.isMute = true
  end
end

-- cpu usage graph
mycpuwidget = awful.widget.graph()
mycpuwidget:set_width(75)
mycpuwidget:set_background_color("#222222")
mycpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 100, 0 }, stops = { {0, "#688ec6"}, {0.5, "#435b80"}, {1, "#29384e" }}})
-- Register widget
vicious.register(mycpuwidget, vicious.widgets.cpu, "$1", 1.37)

-- memory usage graph
mymemwidget = awful.widget.graph()
mymemwidget:set_width(75)
mymemwidget:set_background_color("#262626")
mymemwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 100, 0 }, stops = { {0, "#6ec768"}, {0.5, "#478043"}, {1, "#2c4f29" }}})
vicious.register(mymemwidget, vicious.widgets.mem, "$1", 1.7)

-- network download graph
mynetwidget_down = awful.widget.graph()
mynetwidget_down:set_width(50)
mynetwidget_down:set_background_color("#222222")
mynetwidget_down:set_color({ type = "linear", from = { 0, 0 }, to = { 50, 0 }, stops = { {0, "#c7b968"}, {0.5, "#807743"}, {1, "#4f4a29" }}})
vicious.register(mynetwidget_down, vicious.widgets.net, "${enp0s20u1 down_kb}", 1.2)

-- network upload graph
mynetwidget_up = awful.widget.graph()
mynetwidget_up:set_width(50)
mynetwidget_up:set_background_color("#262626")
mynetwidget_up:set_color({ type = "linear", from = { 0, 0 }, to = { 50, 0 }, stops = { {0, "#c77967"}, {0.5, "#804e42"}, {1, "#4f3129" }}})
vicious.register(mynetwidget_up, vicious.widgets.net, "${enp0s20u1 up_b}", 1.2)

-- Create a textclock widget
mytextclock = awful.widget.textclock(" %d.%m [%a] %H:%M [+1] ", 30)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
  awful.button({        }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({        }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({        }, 4, function() awful.tag.viewprev() end), -- scroll up
  awful.button({        }, 5, function() awful.tag.viewnext() end), -- scroll down
  awful.button({        }, 6, function() awful.tag.viewprev() end), -- scroll left
  awful.button({        }, 7, function() awful.tag.viewnext() end)  -- scroll right
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
    if c == client.focus then
      c.minimized = true
    else
      -- Without this, the following
      -- :isvisible() makes no sense
      c.minimized = false
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      client.focus = c -- This will also un-minimize the client, if needed
      client.focus = c
      c:raise()
    end
  end),
  awful.button({ }, 3, function ()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width=300 })
    end
  end),
  awful.button({ }, 4, function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({ }, 5, function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end)
)

for s = 1, screen.count() do
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(
    awful.util.table.join(
      awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
      awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
      awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
      awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
    )
  )

  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({ height = 20, position = "top", screen = s })

  -- Widgets that are aligned to the left
  local left_layout = wibox.layout.fixed.horizontal()
  left_layout:add(mytaglist[s])
  left_layout:add(mypromptbox[s])
  left_layout:add(mynetwidget_up)
  left_layout:add(mynetwidget_down)
  left_layout:add(mymemwidget)
  left_layout:add(mycpuwidget)

  -- Widgets that are aligned to the right
  local right_layout = wibox.layout.fixed.horizontal()
  --right_layout:add(volchg.wid) -- replaced by pasystray
  if s == 1 then right_layout:add(wibox.widget.systray()) end
  right_layout:add(mytextclock)
  right_layout:add(mylayoutbox[s])
  
  -- Now bring it all together (with the tasklist in the middle)
  local layout = wibox.layout.align.horizontal()
  layout:set_left(left_layout)
  layout:set_middle(mytasklist[s])
  layout:set_right(right_layout)

  mywibox[s]:set_widget(layout)
end
-- Wibox }}}

-- {{{ Mouse bindings
root.buttons(
  awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
  )
)
-- Mouse bindings }}}


-- {{{ Key bindings
globalkeys = awful.util.table.join(
  -- quit and restart awesome
  awful.key({ modkey, "Control"       }, "r", awesome.restart),
  awful.key({ modkey, "Shift"         }, "q", awesome.quit),

  -- tag navigation
  awful.key({ modkey,                 }, "Left",   awful.tag.viewprev       ),
  awful.key({ modkey,                 }, "h",      awful.tag.viewprev       ),
  awful.key({ modkey,                 }, "Right",  awful.tag.viewnext       ),
  awful.key({ modkey,                 }, "l",      awful.tag.viewnext       ),
  awful.key({ modkey,                 }, "Escape", awful.tag.history.restore),

  -- focus / moving windows
  awful.key({ modkey,                 }, "j",
  function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey, "Shift"         }, "j", function () awful.client.swap.byidx(  1) end),
  awful.key({ modkey,                 }, "k",
  function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({ modkey, "Shift"         }, "k", function () awful.client.swap.byidx( -1) end),

  -- Layout manipulation
  awful.key({ modkey,                 }, "Tab",
  function ()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end),
  awful.key({ modkey,                 }, "u",     function () awful.tag.incmwfact( 0.05)    end),
  awful.key({ modkey,                 }, "i",     function () awful.tag.incmwfact(-0.05)    end),
  awful.key({ modkey, "Shift"         }, "u",     function () awful.tag.incnmaster(-1)      end),
  awful.key({ modkey, "Shift"         }, "i",     function () awful.tag.incnmaster( 1)      end),
  awful.key({ modkey, "Control"       }, "u",     function () awful.tag.incncol(-1)         end),
  awful.key({ modkey, "Control"       }, "u",     function () awful.tag.incncol( 1)         end),
  awful.key({ modkey,                 }, "space", function () awful.layout.inc(layouts,  1) end),
  awful.key({ modkey, "Shift"         }, "space", function () awful.layout.inc(layouts, -1) end),

  -- Prompts
  awful.key({ modkey,                 }, "w",     function () mymainmenu:show({keygrabber=true}) end),
  awful.key({ altkey,                 }, "F2",    function () mypromptbox[mouse.screen]:run()    end),
  awful.key({ altkey,                 }, "F1",
  function ()
    awful.prompt.run({ prompt = "Run Lua code: " },
    mypromptbox[mouse.screen].widget,
    awful.util.eval,
    nil,
    awful.util.getdir("cache") .. "/history_eval")
  end),

  -- Sound control

  -- sound volume up
  awful.key({                         }, "XF86AudioRaiseVolume", function () volume.up() end),

  -- sound volume down
  awful.key({                         }, "XF86AudioLowerVolume", function () volume.down() end),

  -- sound mute/unmute
  awful.key({                         }, "XF86AudioMute", function () volume.toggleMute() end),

  -- Removable Volume management (devmon)

  -- unmount/remove all removable devices
  awful.key({ modkey, "Shift"         }, ",",        function () awful.util.spawn('devmon --unmount-all --sync --exec-on-drive "notify-send \\"mount %l\\" \\"<b>%f</b> => <b>%d</b>\\"" --exec-on-unmount "notify-send \\"unmount %l\\" \\"<b>%f</b> => <b>%d</b>\\"" --exec-on-remove "notify-send \\"remove <b>%f</b>\\""') end),

  -- mount all removable devices
  awful.key({ modkey, "Shift"         }, ".",        function () awful.util.spawn('devmon --mount-all --sync --exec-on-drive "notify-send \\"mount %l\\" \\"<b>%f</b> => <b>%d</b>\\"" --exec-on-unmount "notify-send \\"unmount %l\\" \\"<b>%f</b> => <b>%d</b>\\"" --exec-on-remove "notify-send \\"remove <b>%f</b>\\""') end),


  -- Spawn programs

  -- launch terminal
  awful.key({ modkey,                 }, "Return",   function () awful.util.spawn(terminal_cmd) end),
  awful.key({ modkey,                 }, "KP_Enter", function () awful.util.spawn(terminal_cmd) end),

  -- launch root terminal
  awful.key({ modkey, "Shift"         }, "Return",   function () awful.util.spawn(terminal_root_cmd) end),

  -- launch filemanager (primary)
  awful.key({ modkey,                 }, "e",        function () awful.util.spawn(filemanager1_cmd) end),
                                                     
  -- launch filemanager (primary, root)                       
  awful.key({ modkey, "Shift"         }, "e",        function () awful.util.spawn(filemanager1_root_cmd) end),

  -- launch filemanager (alternative)
  awful.key({ modkey,                 }, "d",        function () awful.util.spawn(filemanager2_cmd) end),
                                                     
  -- launch filemanager (alternative, root)                       
  awful.key({ modkey, "Shift"         }, "d",        function () awful.util.spawn(filemanager2_root_cmd) end),
                                                     
  -- launch editor                                   
  awful.key({ modkey,                 }, "g",        function () awful.util.spawn(editor_cmd) end),

  -- launch root editor                                   
  awful.key({ modkey, "Shift"         }, "g",        function () awful.util.spawn(editor_root_cmd) end),
                                                     
  -- switch to german keyboard layout                
  awful.key({ modkey,                 }, "F11",      function () awful.util.spawn(kbd_switch2_de_cmd ) end),

  -- switch to german keyboard layout
  awful.key({ modkey,                 }, "F12",      function () awful.util.spawn(kbd_switch2_us_cmd ) end),

  -- launch eject
  awful.key({ modkey,                 }, "y",        function () awful.util.spawn(eject_cmd) end),

  -- kill firefox flashplugins
  awful.key({ modkey, "Shift"         }, "f",        function () awful.util.spawn(killallFlash_cmd) end),

  -- kill firefox
  awful.key({ modkey, "Shift"         }, "v",        function () awful.util.spawn(killallFirefox_cmd) end),

  -- launch htop
  awful.key({ "Control", "Shift"      }, "Escape",   function () awful.util.spawn("urxvt -e htop") end),
  awful.key({ "Control", "Shift", altkey  }, "Escape",   function () awful.util.spawn("gksu 'urxvt -e htop'") end),

  -- lock the screen
  awful.key({ modkey,                 }, "z",        function () awful.util.spawn(lock_screen_cmd) end),

  -- launch speedcrunch
  awful.key({ modkey,                 }, "c",        function () awful.util.spawn("speedcrunch") end),

  -- launch xfdesktop
  awful.key({ modkey,                 }, "F1",       function () awful.util.spawn("xfdesktop") end),

  -- launch thunderbird
  awful.key({ modkey,                 }, "F2",       function () awful.util.spawn("thunderbird") end),

  -- launch firefox
  awful.key({ modkey,                 }, "F3",       function () awful.util.spawn("firefox") end),

  -- launch firefox profile plain
  awful.key({ modkey, "Shift"         }, "F3",       function () awful.util.spawn("firefox -P plain") end),

  -- launch chromium
  awful.key({ modkey,                 }, "F4",       function () awful.util.spawn("chromium") end),

  -- launch audacious
  awful.key({ modkey,                 }, "a",        function () awful.util.spawn("audacious") end)

)

clientkeys = awful.util.table.join(
  -- move / resize floating windows; resizing of tiled windows can be found in the globalkeys table

  -- dec size Y
  awful.key({ modkey, altkey    },          "j",    function () awful.client.moveresize(  0,   0,   0,  20) end),
  awful.key({ modkey, "Shift", altkey    }, "j",    function () awful.client.moveresize(  0,   0,   0,  60) end),

  -- inc size Y
  awful.key({ modkey, altkey    },          "k",    function () awful.client.moveresize(  0,   0,   0, -20) end),
  awful.key({ modkey, "Shift", altkey    }, "k",    function () awful.client.moveresize(  0,   0,   0, -60) end),

  -- dec size X
  awful.key({ modkey, altkey    },          "l",    function () awful.client.moveresize(  0,   0,  20,   0) end),
  awful.key({ modkey, "Shift", altkey    }, "l",    function () awful.client.moveresize(  0,   0,  60,   0) end),

  -- inc size X
  awful.key({ modkey, altkey    },          "h",    function () awful.client.moveresize(  0,   0, -20,   0) end),
  awful.key({ modkey, "Shift", altkey    }, "h",    function () awful.client.moveresize(  0,   0, -60,   0) end),

  -- move left
  awful.key({ modkey, "Control" },          "h",    function () awful.client.moveresize(-20,   0,   0,   0) end),
  awful.key({ modkey, "Shift", "Control" }, "h",    function () awful.client.moveresize(-60,   0,   0,   0) end),

  -- move right
  awful.key({ modkey, "Control" },          "l",    function () awful.client.moveresize( 20,   0,   0,   0) end),
  awful.key({ modkey, "Shift", "Control" }, "l",    function () awful.client.moveresize( 60,   0,   0,   0) end),

  -- move down
  awful.key({ modkey, "Control" },          "j",    function () awful.client.moveresize(  0,  20,   0,   0) end),
  awful.key({ modkey, "Shift", "Control" }, "j",    function () awful.client.moveresize(  0,  60,   0,   0) end),

  -- move up
  awful.key({ modkey, "Control" },          "k",    function () awful.client.moveresize(  0, -20,   0,   0) end),
  awful.key({ modkey, "Shift", "Control" }, "k",    function () awful.client.moveresize(  0, -60,   0,   0) end),


  -- toggle titlebar TODO: needs further investigation
  awful.key({ modkey                  }, "Up",       function (c) end),


  -- Move client to screen
  awful.key({ modkey,                 }, "o",        awful.client.movetoscreen                          ),


  -- layout things

  -- toggle client fullscreen (causes confusion on some clients that are fullscreen aware themselfes)
  awful.key({ modkey,                 }, "f",        function (c) c.fullscreen = not c.fullscreen  end),

  -- toggle sticky
  awful.key({ modkey,                 }, "s",        function (c) c.sticky = not c.sticky          end),

  -- like the "x" in windows
  awful.key({ modkey, "Shift"         }, "c",        function (c) c:kill()                         end),

  -- toggle floating
  awful.key({ modkey, "Control"       }, "space",    awful.client.floating.toggle                     ),

  -- move the client with the focus to the "prime" position in the layout
  awful.key({ modkey, "Control"       }, "Return",   function (c) c:swap(awful.client.getmaster()) end),

  -- force this client to redraw
  awful.key({ modkey, "Shift"         }, "r",        function (c) c:redraw()                       end),
  
  -- toggle "keep this client on top all the time"
  awful.key({ modkey,                 }, "t",        function (c) c.ontop = not c.ontop            end), 

  -- move window to the left/right workspace
  awful.key({ modkey, "Shift"         }, "Left" ,    function () client_tag_moveLeft()  end ),
  awful.key({ modkey, "Shift"         }, "h"    ,    function () client_tag_moveLeft()  end ),
  awful.key({ modkey, "Shift"         }, "Right",    function () client_tag_moveRight() end ),
  awful.key({ modkey, "Shift"         }, "l"    ,    function () client_tag_moveRight() end )
)


-- Be careful: We use keycodes to make this work on any keyboard layout.
-- Following code should map on the number-keys on the top row of your keyboard.

-- 9 + nrOfTag = keycodeForTag
KEYCODEOFFS = 9

-- Limit nr. of accessible tags via keys
MAXTAGKEY = 13 -- here: 1,...,0,-,=,<BS>

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
  keynumber = math.min(MAXTAGKEY, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
  awful.key({ modkey }, "#" .. i + KEYCODEOFFS,
  function ()
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewonly(tag)
    end
  end),
  awful.key({ modkey, "Control" }, "#" .. i + KEYCODEOFFS,
  function ()
    local screen = mouse.screen
    local tag = awful.tag.gettags(screen)[i]
    if tag then
      awful.tag.viewtoggle(tag)
    end
  end),
  awful.key({ modkey, "Shift" }, "#" .. i + KEYCODEOFFS,
  function ()
    if client.focus then
      local tag = awful.tag.gettags(client.focus.screen)[i]
      if tag then
        awful.client.movetotag(tag)
      end
    end
  end),
  awful.key({ modkey, "Control", "Shift" }, "#" .. i + KEYCODEOFFS,
  function ()
    if client.focus then
      local tag = awful.tag.gettags(client.focus.screen)[i]
      if tag then
        awful.client.toggletag(tag)
      end
    end
  end))
end

-- Mouse buttons
clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- Key bindings }}}

-- {{{ Rules
awful.rules.rules = {
  {
    rule = { }, -- All clients will match this rule.
    properties = {
      --size_hints_honor     = false,
      --maximized_vertical   = false, --breaks floating
      --maximized_horizontal = false,

      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      keys         = clientkeys,
      buttons      = clientbuttons
    }
  }, {
    rule       = { name = "about", name = "About" },
    properties = { floating = true }
  }, {
    rule       = { class = "Audacious" },
    properties = { size_hints_honor = false }
  }, {
    rule       = { class = "MPlayer" },
    properties = { floating = true }
  }, {
    rule       = { class = "feh" },
    properties = { floating = true }
  }, {
    rule       = { class = "Thunar", name = "File Operation Progress" },
    properties = { floating = true }
  }, {
    rule       = { class = "Pidgin" },
    properties = { floating = true }
  }, {
    rule       = { class = "SpeedCrunch" },
    properties = { floating = true }
  }, {
    rule       = { class = "libreoffice" },
    properties = { floating = false }
  }, {
    rule       = { class = "Xfdesktop" },
    properties = { floating = false, tag = tags[1][1] }
  }, {
    rule       = { class = "Xmessage" },
    properties = { floating = true }
  }
}
-- Rules }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
  -- Enable sloppy focus
  c:connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Put windows in a smart way, only if they do not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end

  local titlebars_enabled = false
  if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
    awful.button({ }, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
    )

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(awful.titlebar.widget.iconwidget(c))
    left_layout:buttons(buttons)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(awful.titlebar.widget.floatingbutton(c))
    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    right_layout:add(awful.titlebar.widget.minimizebutton(c))
    right_layout:add(awful.titlebar.widget.stickybutton(c))
    right_layout:add(awful.titlebar.widget.ontopbutton(c))
    right_layout:add(awful.titlebar.widget.closebutton(c))

    -- The title goes in the middle
    local middle_layout = wibox.layout.flex.horizontal()
    local title = awful.titlebar.widget.titlewidget(c)
    title:set_align("center")
    middle_layout:add(title)
    middle_layout:buttons(buttons)

    -- Now bring it all together
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)
    layout:set_middle(middle_layout)

    awful.titlebar(c):set_widget(layout)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- Signals }}}

-- {{{ Hooks
timer_low = timer({ timeout = 10 })
-- timer_low:connect_signal("timeout", function() volchg.mixcmd() end)
timer_low:start()
-- Hooks }}}

-- Autorun programs
autorun = true
autorunApps = 
{ 
  "awesome_autostart",
  "npd start",
  "conkys_start",
}
if autorun then
  for n = 1, #autorunApps do
    awful.util.spawn(autorunApps[n])
  end
end

