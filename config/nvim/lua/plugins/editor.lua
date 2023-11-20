return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- add keybindings
    keys = {
      {
        "<C-n>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Toggle Neotree (CWD)",
      },
    },
  },
  { "towolf/vim-helm" },
  {
    -- tree-sitter ensure installed
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = "all"
    end,
  },
}
