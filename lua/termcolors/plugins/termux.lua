local module = {}

local function emit_line(config, setting_name, setting_value)
	table.insert(config, setting_name .. "=" .. setting_value)
end

module.generate = function(colorscheme)
	local config = { "# Put the following lines in your /data/data/com.termux/files/home/.termux/colors.properties" }
	emit_line(config, "foreground", colorscheme.foreground)
	emit_line(config, "background", colorscheme.background)
	emit_line(config, "cursor", colorscheme.cursor)
	for i = 0, 255 do
		color_name = "color" .. i
		if colorscheme[color_name] ~= nil then
			emit_line(config, color_name, colorscheme[color_name])
		end
	end
	return config
end

return module
