-- VMware VM compatibility
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Monitor
hl.monitor({
    output   = "",
    mode     = "1920x1200@144",
    position = "auto",
    scale    = 1,
})

-- Programs
local terminal = "kitty"
local menu     = "wofi --show drun"
local mainMod  = "SUPER"

-- Autostart (LierB rice)
hl.on("hyprland.start", function()
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh init")
    hl.exec_cmd("~/.config/waybar/launch.sh")
    hl.exec_cmd("hypridle")
end)

-- Look and Feel (LierB rice)
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 8,
        border_size      = 0,
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
    decoration = {
        rounding         = 5,
        active_opacity   = 0.92,
        inactive_opacity = 0.92,
        blur = {
            enabled = false,
            size    = 3,
            passes  = 1,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

-- Animations
hl.curve("myBezier",     { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("linear",       { type = "bezier", points = { {0, 0},      {1, 1}      } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5},  {0.75, 1}   } })

hl.animation({ leaf = "global",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows",    enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6,  bezier = "default" })

-- Core Keybindings (LierB rice)
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + A",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + D",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + M",      hl.dsp.exit())

-- Waybar & Wallpaper shortcuts
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
-- hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
-- hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces (1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))

-- Mouse move/resize
hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })
