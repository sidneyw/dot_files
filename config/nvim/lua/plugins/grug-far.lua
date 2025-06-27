-- Helper function to create both normal and visual mode mappings
local function create_grug_mappings(key, filter, desc)
  return {
    -- Normal mode mapping
    {
      key,
      function()
        require("grug-far").open({
          prefills = {
            filesFilter = filter,
            flags = "--ignore-case",
          },
        })
      end,
      desc = desc,
    },
    -- Visual mode mapping (includes word under cursor)
    {
      key,
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.expand("<cword>"),
            filesFilter = filter,
            flags = "--ignore-case",
          },
        })
      end,
      desc = desc,
      mode = "v",
    },
  }
end

return {
  "MagicDuck/grug-far.nvim",
  keys = vim
    .iter({
      create_grug_mappings("<localleader>a", "**/api/**/*.ts\n!node_modules", "Grug Far (API)"),
      create_grug_mappings("<localleader>f", "**/frontend/**/*\n!node_modules", "Grug Far (UI)"),
      create_grug_mappings("<localleader>\\", "!node_modules", "Grug Far (All)"),
    })
    :flatten()
    :totable(),
}
