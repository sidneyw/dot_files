return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- Replace the default keymaps
    keys = function()
      return {
        {
          "<C-n>",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Toggle Neotree (CWD)",
        },
      }
    end,
  },
  -- tree-sitter ensure installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = "all"
    end,
  },
  { "nvim-treesitter/playground" },
  { "nvim-treesitter/nvim-treesitter-refactor" },
  { "towolf/vim-helm" },
  -- TPope Plugins
  { "tpope/vim-dispatch" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-unimpaired", enabled = false },
  { "tpope/vim-surround" },
  {
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
    },
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
}
