require"sidneyw.treesitter"
require"sidneyw.telescope"
require"sidneyw.nvim-tree"
require"sidneyw.lualine"
require"sidneyw.cmp"
require"sidneyw.lsp"
require"sidneyw.dap"

require"Comment".setup()

require"gitsigns".setup()

require"symbols-outline".setup{
	highlight_hovered_item = false,
	width = 30,
	show_numbers = true,
}

vim.notify = require"notify"
