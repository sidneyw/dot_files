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
      -- dashboard = {
      --   sections = {
      --     { section = "header" },
      --     { section = "keys", gap = 1, padding = 1 },
      --     function()
      --       local in_git = Snacks.git.get_root() ~= nil
      --       local cmds = {
      --         {
      --           icon = " ",
      --           title = "Git Status",
      --           cmd = "git --no-pager diff --stat -B -M -C",
      --           gap = 10,
      --           padding = 10,
      --           height = 5,
      --         },
      --         {
      --           title = "Notifications",
      --           cmd = "gh notify -s -a -n5",
      --           action = function()
      --             vim.ui.open("https://github.com/notifications")
      --           end,
      --           key = "n",
      --           icon = " ",
      --           height = 5,
      --           enabled = true,
      --         },
      --         {
      --           icon = " ",
      --           title = "Open PRs",
      --           cmd = "gh pr list -L 3",
      --           key = "p",
      --           action = function()
      --             vim.fn.jobstart("gh pr list --web", { detach = true })
      --           end,
      --           height = 7,
      --         },
      --       }
      --       return vim.tbl_map(function(cmd)
      --         return vim.tbl_extend("force", {
      --           pane = 2,
      --           section = "terminal",
      --           enabled = in_git,
      --           padding = 1,
      --           ttl = 5 * 60,
      --           indent = 3,
      --         }, cmd)
      --       end, cmds)
      --     end,
      --     { section = "startup" },
      --   },
      -- },
    },
  },
  {
    "folke/persistence.nvim",
    -- disable all default keymaps
    keys = function()
      return {}
    end,
  },
  -- tree-sitter ensure installed
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
      require("window-picker").setup()
    end,
  },
}
