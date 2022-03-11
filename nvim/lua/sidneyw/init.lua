require("sidneyw.treesitter")
require("sidneyw.telescope")
require("sidneyw.nvim-tree")
require("sidneyw.lualine")
require("sidneyw.cmp")
require("sidneyw.lsp")
require("sidneyw.dap")
require("sidneyw.null-ls")
require("sidneyw.gitsigns")
-- require"sidneyw.keymaps" experimental

require("Comment").setup()

require("nvim-autopairs").setup({})

require("symbols-outline").setup({
	highlight_hovered_item = false,
	width = 40,
	relative_width = false,
	show_numbers = true,
})

vim.notify = require("notify")
