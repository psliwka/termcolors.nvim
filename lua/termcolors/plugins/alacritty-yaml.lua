local module = {}

local color_map = {
	colors = {
		primary = {
			background =  "background",
			forground = "foreground",
		},
		cursor = {
			text = "cursor_text_color",
			cursor = "cursor"
		},
		selection = {
			text = "selection_foreground",
			background = "selection_background",
		},
		normal = {
			black = "color0",
			red = "color1",
			green = "color2",
			yellow = "color3",
			blue = "color4",
			mageneta = "color5",
			cyan = "color6",
			white = "color7"
		},
		bright = {
			black = "color8",
			red = "color9",
			green = "color10",
			yellow = "color11",
			blue = "color12",
			mageneta = "color13",
			cyan = "color14",
			white = "color15"
		}
	}
};

local function quote_str(str)
	return "'" .. str .. "'"
end

local function create_line(indent, key, value)
	local line = string.rep("  ", indent) .. key .. ":"

	if value ~= nil then
		line = line .. " " .. quote_str(value)
	end

	return line
end

local function write_entries(output, colorscheme, map, indent)
	for key, value in pairs(map) do
		if type(value) == "string" then
			-- so our value is a key for the colorscheme, check it exists in 
			-- the colorscheme, if not, ignore it, otherwise write out a line
			if colorscheme[value] ~= nil then
				table.insert(output, create_line(indent, key, colorscheme[value]))
			end
		elseif type(value) == "table" then
			-- If it's a table we assume it's a submap
			table.insert(output, create_line(indent, key))
			write_entries(output, colorscheme, value, indent + 1)
		else
			error("Invalid color map")
		end
	end
end

module.generate = function(colorscheme)
	local output = { "# Put the following lines in your ~/.config/alacritty/alacritty.yml" }

	write_entries(output, colorscheme, color_map, 0)

	return output
end

return module
