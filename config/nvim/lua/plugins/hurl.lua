return {
  "hurl.nvim",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/hurl",
  dependencies = { 
    "nvim-telescope/telescope.nvim", 
    "folke/which-key.nvim",
    "folke/snacks.nvim",
  },
  config = function()
    require("plugins.hurl.core").setup({
      -- Plugin configuration options
      split_direction = "horizontal", -- horizontal, vertical, floating
      output_format = "raw", -- raw, json, formatted
      auto_save = false,
      max_history_entries = 100,
    })
  end,
}