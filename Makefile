BASE_COMMAND = nvim --cmd 'cd lua/ | source termcolors.lua | source ../plugin/termcolors.vim' +TermcolorsShow\ $@

.PHONY: kitty
kitty:
	${BASE_COMMAND}

.PHONY: alacritty
alacritty:
	${BASE_COMMAND}

.PHONY: alacritty-yaml
alacritty-yaml:
	${BASE_COMMAND}

.PHONY: termux
termux:
	${BASE_COMMAND}
