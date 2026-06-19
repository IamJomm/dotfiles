hl.window_rule({ match = { class = "kitty|firefox|zen" }, opacity = 0.8 })
hl.window_rule({ match = { title = ".*(YouTube|.png|.jpg|.jpeg|.webp|.webm|.mp4|.gif).*" }, opacity = 1 })

hl.layer_rule({
	name = "quickshell",
	match = { namespace = "quickshell" },
	no_anim = true,
	blur = true,
	ignore_alpha = 0,
})

hl.window_rule({ match = { class = "Sxiv" }, tag = "+image-viewer" })
hl.window_rule({
	name = "float-image-viewer",
	match = { tag = "image-viewer" },
	float = true,
	center = true,
})

hl.window_rule({ match = { class = "mpv" }, tag = "+video-player" })
hl.window_rule({ match = { initial_title = "VLC media player" }, tag = "+video-player" })
hl.window_rule({
	name = "float-video-player",
	match = { tag = "video-player" },
	float = true,
	center = true,
	size = { 1280, 720 },
})

--My personal
hl.window_rule({ match = { class = "Waydroid" }, fullscreen = true })
