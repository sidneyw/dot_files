return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- Replace the default keymaps
    keys = function()
      return {
        {
          "<C-n>",
          function()
            require("neo-tree.command").execute({ dir = vim.loop.cwd(), toggle = true })
          end,
          desc = "Toggle Neotree (CWD)",
          -- make it not wait at all
          nowait = true,
        },
        {
          "<leader>gt",
          function()
            require("neo-tree.command").execute({ source = "git_status", toggle = true })
          end,
          desc = "Toggle Neotree (Git Status)",
          nowait = true,
        },
        {
          "<leader>eb",
          function()
            require("neo-tree.command").execute({ source = "buffers", toggle = true })
          end,
          desc = "Toggle Neotree (Buffers)",
        },
      }
    end,
  },
  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      indent = { animate = { enabled = false } },
    },
  },
  {
    "folke/persistence.nvim",
    -- disable all default keymaps
    keys = function()
      return {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = "all"
      opts.textobjects = vim.tbl_extend("force", opts.textobjects, {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      })
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
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      -- require("window-picker").setup()
      require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}
