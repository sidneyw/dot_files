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

require('lualine').setup{
  options = {theme = 'ayu_dark'},
  -- options = {theme = 'nightfox'},
  -- extensions = {},
  tabline = {
    -- lualine_a = {
      -- { 'tabs', mode = 2, }
    -- },
    -- lualine_x = { require'tabline'.tabline_tabs },
    -- lualine_c = { require'tabline'.tabline_buffers },
  },
}

-- vim.opt.termguicolors = true

require("bufferline").setup{
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        -- text = "File Explorer",
        -- text_align = "center",
      }
    },
    separator_style = "slant",
    diagnostics = "coc",
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "yaml", "helm" },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
