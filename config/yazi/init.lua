function Entity:icon()
	local icon = self._file:icon()
	if not icon then
		return ""
	else
		return icon.text .. " "
	end
end
