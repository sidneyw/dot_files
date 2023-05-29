require("global") -- experimental

if require("first-load")() then
	return
end

vim.g.mapleader = "-"
vim.g.maplocalleader = "\\"

require("plugins")
require("autocommands")

require("sidneyw.lsp")
require("sidneyw.tab")

require("sidneyw.plugins.dap").setup()
require("sidneyw.plugins.fugitive")
require("sidneyw.plugins.gitsigns")
require("sidneyw.plugins.lualine")
require("sidneyw.plugins.luasnip-cmp")
require("sidneyw.plugins.null-ls")
require("sidneyw.plugins.nvim-tree")
require("sidneyw.plugins.symbolsoutline")
require("sidneyw.plugins.telescope")
require("sidneyw.plugins.treesitter")
-- require("sidneyw.plugins.diffview")

require("sidneyw.chronosphere")

vim.api.nvim_set_keymap(
	"n",
	"ge",
	[[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
	{ noremap = true, silent = true }
)

-- Reload init.lua
nmap({
	"<leader>sv",
	function()
		R("sidneyw.luasnip-cmp")
	end,
})

vim.notify = require("notify")
vim.cmd([[colorscheme gruvbox]])
-- colorscheme monokai-phoenix
-- colorscheme badwolf
-- colorscheme onedark
-- colorscheme dracula_blood
-- colorscheme nightfox
-- colorscheme srcerydrk
-- colorscheme papercolor
-- colorscheme brogrammer
-- colorscheme turtles
-- colorscheme molokai_dark
