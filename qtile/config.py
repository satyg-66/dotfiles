from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess
import theme

@hook.subscribe.startup_once
def autostart():
    autostartScript = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostartScript])

# Choose ONE of the following themes;
    # dracula
    # doomOne
    # gruvboxDark
    # nord
    # oceanicNext
    # tomorrowNight
    # macchiato
color = theme.dracula()

# My variables
mod = "mod4"
#terminal = guess_terminal()
myBrowser = "firefox"
myTerminal = "termite"
myFilemanager = "thunar"

keys = [ # Modkey keybindings
    Key([mod], "e", lazy.spawn(myFilemanager), desc="Launch FileManager"),
    Key([mod], "f", lazy.spawn(myBrowser), desc="Launch Browser"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "Return", lazy.spawn(myTerminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    #Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "n", lazy.window.toggle_floating(), desc="Toggle floating"),
    # Modkey + Shift keybindngs
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    #Key([mod, "shift"], "Return", lazy.spawn("dmenu_run"),
    Key([mod, "shift"], "Return", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    #Key(
    #    [mod, "shift"],
    #    "Return",
    #    lazy.layout.toggle_split(),
    #    desc="Toggle between split and unsplit sides of stack",
    #),
    # Modkey + Control keybindings
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

# Mouse bindings - Drag floating layouts.
mouse = [
    Drag(["shift"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(["shift"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(["shift"], "Button2", lazy.window.bring_to_front()),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(
        font = "Ubuntu",
        fontsize = 10,
        margin = 10,
        border_width=2, max_border_width=2,
        border_focus=color[7], border_normal=color[10]
        ),
    layout.Columns(
        border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4
        ),
    layout.Max(),
    layout.Floating(
        border_width=2, max_border_width=2,
        border_focus="#ff79c6", border_normal="#6272a4"
        )
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Source Code Pro",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                widget.Image(
                    background=color[0],
                    filename='~/.config/qtile/images/python.svg',
                    scale = "False",
                    ),
                widget.GroupBox(
                    #hide_unused=True,
                    fontsize=15,
                    background=color[0],
                    highlight_method="line",
                    active=color[7],
                    inactive=color[10],
                    other_screen_border=color[8],
                    this_current_screen_border=color[4]
                    ),
                widget.TextBox("",
                    foreground=color[11],
                    background=color[0],
                    fontsize=20
                    ),
                widget.Prompt(
                    foreground=color[5],background=color[0]
                    ),
                widget.WindowName(
                    background=color[0],
                    foreground=color[6]
                    ),
                #widget.Chord(
                #    chords_colors={
                #        "launch": ("#ff0000", "#ffffff"),
                #    },
                #    name_transform=lambda name: name.upper(),
                #),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.Systray(
                    background=color[0],
                    foreground=color[7],
                    icon_size=10
                    ),
                widget.Volume(
                    background=color[0],
                    foreground=color[7],
                    fmt='Vol: {}',
                    ),
                widget.TextBox("",
                        foreground=color[10],
                        background=color[0],
                        fontsize=10
                    ),
                widget.CheckUpdates(
                    background=color[0],
                    distro="Arch_checkupdates",
                    display_format="Updates: {updates} ",
                    update_interval=900,
                    no_update_string='No updates',
                    colour_have_updates=color[3],
                    colour_no_updates=color[4],
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerminal + ' -e sudo pacman -Syu')}
                    ),
                widget.TextBox("",
                        foreground=color[10],
                        background=color[0],
                        fontsize=10
                    ),
                widget.Clock(
                    foreground=color[5],background=color[0],
                    format="%y-%m-%d %A %H:%M"
                    ),
                widget.TextBox("",
                        foreground=color[10],
                        background=color[0],
                        fontsize=10
                    ),
                widget.QuickExit(
                    background=color[0]
                    ),
            ],
            24,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
	Match(title="Calculator"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
