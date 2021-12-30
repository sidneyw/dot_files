require"sidneyw.treesitter"
require"sidneyw.telescope"
require"sidneyw.nvim-tree"
require"sidneyw.lualine"
require"sidneyw.cmp"
require"sidneyw.lsp"

require"gitsigns".setup()

require("dap-go").setup()
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

vim.notify = require("notify")

require"symbols-outline".setup{
	highlight_hovered_item = false,
	width = 30,
	show_numbers = true,
}

-- require("bufferline").setup{
--   options = {
--     offsets = {
--       {
--         filetype = "NvimTree",
--         -- text = "File Explorer",
--         -- text_align = "center",
--       }
--     },
--    show_close_icon = true,
--     separator_style = "slant",
--     diagnostics = "coc",
--   }
-- }

