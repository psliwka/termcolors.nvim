# Termcolors.nvim – generate colors for your terminal from any Neovim colorscheme :rainbow:

This Neovim plugin generates color schemes for terminal emulators. It is
primarily meant to help Neovim colorscheme creators to easily provide
good-looking matching terminal colorschemes as extras. It can also be used by
end users, to create an appropriate config for their terminal in case the
colorscheme of their choice does not come with such extra themes on its own. Is
your editor already pretty, but your terminal seems off? You might want to give
_termcolors.nvim_ a try!

![termcolors.nvim output screenshot](screenshot.png) _termcolors.nvim output,
additionally colorized by [colorizer.lua]_

[colorizer.lua]: https://github.com/norcalli/nvim-colorizer.lua

## Installation

Install the plugin using your favorite plugin manager, for example [vim-plug]:

```
Plug 'psliwka/termcolors.nvim'
```

Alternatively, you may run this plugin without installing. For details, see the
[Using standalone](#using-standalone) section.

## Using as plugin

1. Configure Neovim to use colorsheme of your choice
2. Ensure your `'background'` is set correctly (i.e. is set to `dark` or `light`
   to match your actual colorscheme background)
3. Run `:TermcolorsShow` command and copy resulting code to your terminal's
   config file
4. Restart your terminal, or tell it to reload its config file (e.g.
   `ctrl+cmd+.` for kitty)

## Using standalone

As this plugin is rarely needed in your daily work (you usually use it once,
when you switch your colorscheme and/or terminal program), it usually makes
sense to run in directly from the repository, without cluttering your
`init.lua`. To do so:

1. Clone this repository and `cd` into it
2. Run `make <TERMINAL NAME>`, for example `make kitty`
3. Update your terminal configuration as described in the previous section

## Advanced Configuration

In order to configure Termcolors for your specific usage you can call

```
require'termcolors'.setup {
    -- If you write your own plugin, you can declare it here so Termcolors
    -- is aware of it
    --
    -- Otherwise you don't need to specify this option at all
    plugins = {
        ["my_custom_plugin_name"] = require'path_to_your_plugin_module'
    },
    -- The name of the default plugin you wish to use.
    -- If not specified, it'll be set to `kitty`
    default_plugin = "my_custom_plugin_name"
}
```

## Plugins

Termcolors ships with two plugins:

* kitty
* alacritty

To call the generator for a sepecific plugin you can run 
`:TermcolorsShow <plugin_name>` and it'll generate output for the terminal that
plugin is for.

Calling `:TermcolorsShow` without an argument will instead use the configured
default plugin to generate output

## Development status

Right now, this project is in its infancy. It supports the following terminal
emulators:

- [kitty](https://github.com/kovidgoyal/kitty)
- [alacritty](https://github.com/alacritty/alacritty)

Additionally, its heuristics for detecting proper colors for various terminal
elements may not work for all colorschemes. So far, it has been tested and
confirmed to work for the following themes:

- [doom-one.nvim](https://github.com/NTBBloodbath/doom-one.nvim)

These two lists will hopefully expand in the future. Feel encouraged to submit
PRs! :wink:

## Credits

Created by [Piotr Śliwka](https://github.com/psliwka).

Some color processing code (for generating pretty terminal's tabline background)
has been taken from [bufferline.nvim].

[bufferline.nvim]: https://github.com/akinsho/bufferline.nvim

## License

[MIT](LICENSE)
