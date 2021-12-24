require("sidneyw.telescope")

-- require('tabline').setup {
--   enable = true,
--   options = {
--     show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
--     show_devicons = true, -- this shows devicons in buffer section
--     show_bufnr = false, -- this appends [bufnr] to buffer section,
--     show_filename_only = false,
--   }
-- }

require('dap-go').setup()
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

require'tabline'.setup {
  enable = true,
  options = {
    show_tabs_always = true,
  }
}

require('lualine').setup{
  options = {theme = 'ayu_dark'},
  tabline = {
    lualine_x = { require'tabline'.tabline_tabs },
    lualine_c = { require'tabline'.tabline_buffers },
  },
}

vim.notify = require("notify")

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

require'nvim-treesitter.configs'.setup {
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
