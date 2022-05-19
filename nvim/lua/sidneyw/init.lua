function nnoremap(lhs, fn)
	vim.keymap.set("n", lhs, fn, { noremap = true })
end

require("sidneyw.treesitter")
require("sidneyw.nvim-tree")
require("sidneyw.lualine")
require("sidneyw.tab")
require("sidneyw.cmp")
require("sidneyw.lsp")
require("sidneyw.dap")
require("sidneyw.null-ls")
require("sidneyw.gitsigns")
-- require"sidneyw.keymaps" experimental

require("Comment").setup()

require("nvim-autopairs").setup({})

require("mini.trailspace").setup()

require("symbols-outline").setup({
	highlight_hovered_item = false,
	width = 40,
	relative_width = false,
	show_numbers = true,
})

vim.notify = require("notify")
require("sidneyw.telescope")
