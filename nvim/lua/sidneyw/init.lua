require"sidneyw.telescope"
require"sidneyw.lualine"
require"sidneyw.nvim-tree"

require("dap-go").setup()
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

vim.notify = require("notify")

require"nvim-treesitter.configs".setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "yaml", "helm" },
  },
  indent = {
    enable = true
  }
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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
