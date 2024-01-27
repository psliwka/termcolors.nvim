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
			magenta = "color5",
			cyan = "color6",
			white = "color7"
		},
		bright = {
			black = "color8",
			red = "color9",
			green = "color10",
			yellow = "color11",
			blue = "color12",
			magenta = "color13",
			cyan = "color14",
			white = "color15"
		}
	}
};

local function quote_str(str)
	return "\"" .. str .. "\""
end

local function write_group_header(output, path)
	if #path == 0 then return end
	table.insert(output, "[" .. table.concat(path, ".") .. "]")
end

local function write_key_value_pair(output, key, value)
	if value == nil then return end
	table.insert(output, key .. " = " .. quote_str(value))
end

local function write_entries(output, colorscheme, map, path)
	path = path or {}

	local group_header_written = false

	for key, value in pairs(map) do
		if type(value) == "string" then
			if colorscheme[value] ~= nil then
				-- Write the group header if it hasn't been written already
				if not group_header_written and #path > 0 then
					table.insert(output, "")
					write_group_header(output, path)
					group_header_written = true
				end
				-- Write the colorscheme entry
				write_key_value_pair(output, key, value)
			end
		elseif type(value) == "table" then
			table.insert(path, key)
			write_entries(output, colorscheme, value, path)
			table.remove(path)
		else
			error("Invalid color map")
		end
	end
end

module.generate = function(colorscheme)
	local output = { "# Put the following lines in your ~/.config/alacritty/alacritty.toml" }

	write_entries(output, colorscheme, color_map)

	return output
end

return module
