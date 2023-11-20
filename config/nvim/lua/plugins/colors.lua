return {
  {
    "luisiacc/gruvbox-baby",
    config = function()
      -- make the background darker
      vim.g.gruvbox_baby_background_color = "dark"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-baby",
    },
  },
}
