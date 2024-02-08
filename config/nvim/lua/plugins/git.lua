return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>ga", "<cmd>Gwrite<CR>", desc = "Git add %" },
      { "<leader>gb", "<cmd>Git blame<CR>", desc = "Git blame" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      -- { "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git diff" },
      { "<leader>gl", "<cmd>Git pull<CR>", desc = "Git pull" },
      { "<leader>gr", "<cmd>Gremove<CR>", desc = "Git remove" },
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
      { "<leader>gu", "<cmd>Git push -u<CR>", desc = "Git push" },

      {
        "<leader>gp",
        function()
          vim.cmd([[ !gh pr view --web || gh pr create --web ]])
        end,
        desc = "Open or create a PR",
      },

      { "<leader>gn", "<cmd>.GBrowse<CR>", desc = "Open current line on github" },
      { "<leader>go", "<cmd>.GBrowse!<CR>", desc = "Copy the github link to the clipboard" },

      { "<leader>gn", "<cmd>'<,'>GBrowse<CR>", mode = { "v" }, desc = "Open selected lines on github" },
      { "<leader>go", "<cmd>'<,'>GBrowse!<CR>", mode = { "v" }, desc = "Copy the github link to the clipboard" },
    },
    init = function()
      vim.cmd([[
        cnoreabbr Gco Git co
        cnoreabbr Gpush Git push
        cnoreabbr Gcommit Git commit
        cnoreabbr Gcb Git co -b
        cnoreabbr Gstash Git stash
      ]])
    end,
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gdd", "<cmd>DiffviewOpen master<CR>", desc = "Open diff view against master" },
      { "<leader>gdh", "<cmd>DiffviewOpen<CR>", desc = "Open diff view against HEAD" },
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
    },
  },
}
