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
--
-- Using a Lua function in a key mapping in 0.7
-- vim.api.nvim_set_keymap("n", "<leader>H", "", {
-- 	noremap = true,
-- 	callback = function()
-- 		print("Hello world!")
-- 	end,
-- })

vim.keymap.set("n", "<leader>H", function()
	print("Hello world!")
end)
-- vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = true, buffer = 5 })

-- Creating an autocommand in 0.7
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		print("Entered buffer " .. args.buf .. "!")
-- 	end,
-- 	desc = "Tell me when I enter a buffer",
-- })

-- Creating a custom user command in 0.7
vim.api.nvim_create_user_command("SayHello", function(args)
	print("Hello " .. args.args)
end, {
	nargs = "*",
	desc = "Say hi to someone",
})
