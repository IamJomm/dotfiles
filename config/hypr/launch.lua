hl.on("hyprland.start", function()
	--Needed
	hl.exec_cmd(
		"systemctl --user start hyprland-session.target & wl-paste --type text --watch cliphist store & wl-paste --type image --watch cliphist store & udiskie"
	)
	hl.exec_cmd("quickshell & hyprpaper")
	--My personal
	hl.exec_cmd(
		"sleep 5 && obs --startreplaybuffer --minimize-to-tray & com.github.wwmm.easyeffects -w & /usr/bin/kdeconnectd & /usr/bin/kdeconnect-indicator"
	)
end)

hl.on("hyprland.shutdown", function()
	os.execute("pkill obs; systemctl --user stop hyprland-session.target && sleep 1.5")
end)
