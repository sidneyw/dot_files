return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<localleader>a",
      function()
        require("grug-far").open({
          prefills = {
            filesFilter = "**/api/**/*.ts\n!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (API)",
    },
    {
      "<localleader>a",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            filesFilter = "**/api/**/*.ts\n!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (API)",
      mode = "v",
    },
    {
      "<localleader>f",
      function()
        require("grug-far").open({
          prefills = {
            filesFilter = "**/frontend/**/*\n!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (UI)",
    },
    {
      "<localleader>f",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            filesFilter = "**/frontend/**/*\n!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (UI)",
      mode = "v",
    },
    {
      "<localleader>\\",
      function()
        require("grug-far").open({
          prefills = {
            filesFilter = "!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (UI)",
    },
    {
      "<localleader>\\",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            filesFilter = "!node_modules",
            flags = "--ignore-case",
          },
        })
      end,
      desc = "Grug Far (UI)",
      mode = "v",
    },
  },
}
