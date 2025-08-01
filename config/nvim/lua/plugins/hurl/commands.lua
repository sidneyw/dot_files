local M = {}

function M.setup()
  vim.api.nvim_create_user_command("HurlRun", function()
    require("plugins.hurl.core").run_hurl_file()
  end, {
    desc = "Run current Hurl file"
  })

  vim.api.nvim_create_user_command("HurlRunTest", function()
    require("plugins.hurl.core").run_hurl_test()
  end, {
    desc = "Run current Hurl file in test mode"
  })

  vim.api.nvim_create_user_command("HurlRunVerbose", function()
    require("plugins.hurl.core").run_hurl_verbose()
  end, {
    desc = "Run current Hurl file in verbose mode"
  })

  vim.api.nvim_create_user_command("HurlSetSplitDirection", function(args)
    local direction = args.args
    if direction == "horizontal" or direction == "vertical" or direction == "floating" then
      require("plugins.hurl.config").options.split_direction = direction
      vim.notify("Hurl split direction set to: " .. direction)
    else
      vim.notify("Invalid direction. Use: horizontal, vertical, or floating", vim.log.levels.ERROR)
    end
  end, {
    nargs = 1,
    complete = function()
      return { "horizontal", "vertical", "floating" }
    end,
    desc = "Set Hurl results split direction"
  })
end

return M