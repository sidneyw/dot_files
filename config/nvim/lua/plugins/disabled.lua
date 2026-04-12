return {
  -- bufferline
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-mini/mini.surround", enabled = false },
  --  TODO: Figure out if I'm keeping flash or removing it entirely
  { "folke/flash.nvim", enabled = false },
  -- TODO: illuminate has a bug with the current treesitter version.
  -- Undo this when the bug is fixed.
  { "RRethy/vim-illuminate", enabled = false },
  -- Disabled in favor of fzf-lua
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },
  { "nvim-telescope/telescope-github.nvim", enabled = false },
  { "benfowler/telescope-luasnip.nvim", enabled = false },
  { "nvim-telescope/telescope-media-files.nvim", enabled = false },
  { "nvim-telescope/telescope-cheat.nvim", enabled = false },
}
