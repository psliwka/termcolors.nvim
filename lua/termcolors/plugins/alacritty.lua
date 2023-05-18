local module = {}

local function quote_str(str)
    return "'" .. str .. "'"
end

module.generate = function(colorscheme)
    local config = { "# Put the following lines in your ~/.config/alacritty/alacritty.yml" }

    table.insert(config, "colors:")
    table.insert(config, "  primary:")
    table.insert(config, "    background: " .. quote_str(colorscheme.background))
    table.insert(config, "    foreground: " .. quote_str(colorscheme.foreground))
    table.insert(config, "  cursor:")
    table.insert(config, "    text: " .. quote_str(colorscheme.cursor_text_color))
    table.insert(config, "    cursor: " .. quote_str(colorscheme.cursor))
    table.insert(config, "  selection:")
    table.insert(config, "    text: " .. quote_str(colorscheme.selection_foreground))
    table.insert(config, "    background: " .. quote_str(colorscheme.selection_background))

    table.insert(config, "  normal:")
    table.insert(config, "    black: " .. quote_str(colorscheme["color0"]))
    table.insert(config, "    red: " .. quote_str(colorscheme["color1"]))
    table.insert(config, "    green: " .. quote_str(colorscheme["color2"]))
    table.insert(config, "    yellow: " .. quote_str(colorscheme["color3"]))
    table.insert(config, "    blue: " .. quote_str(colorscheme["color4"]))
    table.insert(config, "    mageneta: " .. quote_str(colorscheme["color5"]))
    table.insert(config, "    cyan: " .. quote_str(colorscheme["color6"]))
    table.insert(config, "    white: " .. quote_str(colorscheme["color7"]))

    table.insert(config, "  bright:")
    table.insert(config, "    black: " .. quote_str(colorscheme["color8"]))
    table.insert(config, "    red: " .. quote_str(colorscheme["color9"]))
    table.insert(config, "    green: " .. quote_str(colorscheme["color10"]))
    table.insert(config, "    yellow: " .. quote_str(colorscheme["color11"]))
    table.insert(config, "    blue: " .. quote_str(colorscheme["color12"]))
    table.insert(config, "    mageneta: " .. quote_str(colorscheme["color13"]))
    table.insert(config, "    cyan: " .. quote_str(colorscheme["color14"]))
    table.insert(config, "    white: " .. quote_str(colorscheme["color15"]))

    return config
end

return module
