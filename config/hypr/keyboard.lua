--Keyboard layout
hl.config({
	input = {
		kb_layout = "us,ua",
		kb_options = "grp:alt_shift_toggle,caps:swapescape",
		touchpad = { natural_scroll = true },
		sensitivity = -0.5,
		accel_profile = "flat",
		follow_mouse = 2,
	},
})

local mainMod = "SUPER"

--Shell
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("qs ipc call quickSettings toggle"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("qs ipc call lockScreen lock"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("qs ipc call powerMenu toggle"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("sh ~/.config/rofi/tools.sh")) --will be replaced later
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd("pkill rofi || cliphist list | rofi -dmenu -p 'Clipboard:'| cliphist decode | wl-copy")
) --will be replaced later

--Programs
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty yazi"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun")) --will be replaced later

--Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim ~/Pictures/Screenshots/"$(date +%c)".png'))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/Screenshots/"$(date +%c)".png'))
--Music
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { repeating = true, locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { repeating = true, locked = true })

--Volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

--Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

--Hyprland Actions
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

--Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

--Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))

--Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--Move/resize windows with keyboard
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })

	hl.bind("escape", hl.dsp.submap("reset"))
end)

--My personal
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd("kitty btop"))

hl.bind(
	mainMod .. " + Y",
	hl.dsp.exec_cmd(
		"obs-cli replay save && notify-send 'OBS' 'Replay saved' -i ~/.config/hypr/assets/file-video-solid.png"
	)
)
hl.bind(
	mainMod .. " + I",
	hl.dsp.exec_cmd(
		"obs-cli record toggle && notify-send 'OBS' 'Record toggled' -i ~/.config/hypr/assets/file-video-solid.png"
	)
)

hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("qs ipc call appLauncher toggle")) --test
