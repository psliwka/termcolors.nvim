local module = {}

local helpers = require'termcolors/helpers'

module.generate = function(colorscheme)
    local config = { "# Put the following lines in your ~/.config/kitty/kitty.conf" }
    for setting_name, setting_value in helpers.ordered_pairs(colorscheme) do
        table.insert(config, setting_name .. " " .. setting_value)
    end
    return config
end

return module
