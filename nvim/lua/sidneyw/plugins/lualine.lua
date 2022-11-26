local lualine = require("lualine")
local tabline = require("tabline")

tabline.setup({
	enable = true,
	options = {
		show_tabs_always = true,
	},
})

lualine.setup({
	options = { theme = "ayu_dark" },
	tabline = {
		lualine_x = { tabline.tabline_tabs },
		lualine_c = { tabline.tabline_buffers },
	},
})
