hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 1,
		col = {
			active_border = "rgba(f4f4f4cc)",
			inactive_border = "rgba(666666cc)",
		},
		layout = "master",
	},
	master = { mfact = 0.5 },
	decoration = {
		rounding = 10,
		blur = {
			enabled = true,
			size = 3,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			popups = true,
		},
		shadow = { enabled = false },
	},
	animations = {
		enabled = true,
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

hl.curve("easeInOut", { type = "bezier", points = { { 0.5, 0 }, { 0.5, 1 } } })
hl.curve("easeIn", { type = "bezier", points = { { 0.5, 0 }, { 1, 1 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0, 0 }, { 0.5, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 2.5, bezier = "easeInOut" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "easeOut" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "easeIn" })
