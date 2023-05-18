local termcolors = {}

local helpers = require'termcolors/helpers'

-- Provided plugins
termcolors.plugins = {
    ["kitty"] = require'termcolors/plugins/kitty',
}

-- The default plugin to use
termcolors.default_plugin = "kitty"

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

local function is_light()
	return vim.opt.background:get() == "light"
end

function termcolors.setup(config)
    -- merge the additionally specified plugins
    --
    -- This should allow people to create plugins sperate from the termcolors
    -- and hook them in
    if config.plugins ~= nil and type(config.plugins) == "table" then
        for k,v in config.plugins do
            termcolors.plugins[k] = v
        end
    end

    termcolors.default_plugin = config.default_plugin or termcolors.default_plugin
end

function termcolors.scrape_current_colorscheme()
	local colors = helpers.ordered_table({})
	colors.foreground = color_from_syntax("Normal", "fg")
	colors.background = color_from_syntax("Normal", "bg")
	for i = 0, 255 do
		colors["color" .. i] = vim.g["terminal_color_" .. i]
	end
	colors.cursor = color_from_syntax("cursor", "bg") or colors.foreground
	colors.cursor_text_color = color_from_syntax("cursor", "fg") or colors.background
	colors.url_color = color_from_syntax("url")
	colors.selection_foreground = color_from_syntax("Visual", "fg") or "none"
	colors.selection_background = color_from_syntax("Visual", "bg")
	colors.tab_bar_background = shade_color(colors.background, is_light() and -20 or -45)
	colors.active_tab_foreground = colors.foreground
	colors.active_tab_background = colors.background
	colors.inactive_tab_foreground = color_from_syntax("Comment", "fg")
	colors.inactive_tab_background = shade_color(colors.background, is_light() and -12 or -25)
	colors.active_border_color = color_from_syntax("TabLineSel")
	colors.inactive_border_color = color_from_syntax("VertSplit")
	colors.bell_border_color = color_from_syntax("TextWarning")

	local cleaned_colors = helpers.ordered_table({})
	for setting_name, setting_value in helpers.ordered_pairs(colors) do
		if setting_value ~= nil then
			cleaned_colors[setting_name] = string.lower(setting_value)
		end
	end
	return cleaned_colors
end

function termcolors.show(plugin_name)
    if plugin_name == nil or plugin_name == "" then
        plugin_name = termcolors.default_plugin
    end

    local plugin = termcolors.plugins[plugin_name]
    if plugin == nil then
        error("Plugin is nil")
    end

    -- Get the current color scheme
    local colorscheme = termcolors.scrape_current_colorscheme()

    -- Generate output buffer
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_name(buf, "Termcolors")
	vim.api.nvim_buf_set_lines(buf, 0, 1, true, plugin.generate(colorscheme))
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "readonly", true)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "conf")
	vim.cmd("buffer " .. buf)
end

return termcolors
