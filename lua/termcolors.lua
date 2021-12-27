local termcolors = {}

local function color_from_syntax(name, type)
	type = type or "fg"
	local result = vim.api.nvim_eval('synIDattr(synIDtrans(hlID("' .. name .. '")), "' .. type .. '#")')
	if result == "" then
		return nil
	else
		return result
	end
end

local function hex_to_rgb(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

local function shade_color(color, percent)
  local r, g, b = hex_to_rgb(color)
  if not r or not g or not b then
    return "NONE"
  end
  r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
  r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
  return string.format("#%02x%02x%02x", r, g, b)
end

function termcolors.scrape_current_colorscheme()
	local colors = {}
	colors.foreground = color_from_syntax("Normal", "fg")
	colors.background = color_from_syntax("Normal", "bg")
	for i=0,15 do
		colors["color" .. i] = vim.g["terminal_color_" .. i]
	end
	colors.cursor = color_from_syntax("cursor", "bg") or colors.foreground
	colors.cursor_text_color = color_from_syntax("cursor", "fg") or colors.background
	colors.url_color = color_from_syntax("url")
	colors.selection_foreground = color_from_syntax("Visual", "fg") or "none"
	colors.selection_background = color_from_syntax("Visual", "bg")
	colors.tab_bar_background = shade_color(colors.background, -45)  -- TODO: tweak for light themes
	colors.active_tab_foreground = colors.foreground
	colors.active_tab_background = colors.background
	colors.inactive_tab_foreground = color_from_syntax("Comment", "fg")
	colors.inactive_tab_background = shade_color(colors.background, -25)  -- TODO: tweak for light themes
	return colors
end

function termcolors.generate_kitty_config()
	for setting_name, setting_value in pairs(termcolors.scrape_current_colorscheme()) do
		print(setting_name .. " " .. setting_value)
	end
end

return termcolors
