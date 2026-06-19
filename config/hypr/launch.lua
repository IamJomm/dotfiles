hl.on("hyprland.start", function()
	--Needed
	hl.exec_cmd(
		"quickshell & hyprpaper & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & udiskie"
	)
	--My personal
	hl.exec_cmd(
		"sleep 5 && obs --startreplaybuffer --minimize-to-tray & com.github.wwmm.easyeffects -w & /usr/bin/kdeconnectd & /usr/bin/kdeconnect-indicator"
	)
	--Needed
	hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
	os.execute("pkill obs; systemctl --user stop hyprland-session.target && sleep 0.1")
end)
