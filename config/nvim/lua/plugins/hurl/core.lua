local config = require("plugins.hurl.config")
local ui = require("plugins.hurl.ui")
local history = require("plugins.hurl.history")
local commands = require("plugins.hurl.commands")
local keymaps = require("plugins.hurl.keymaps")
local notify = require("snacks").notify

local M = {}

function M.setup(opts)
  config.setup(opts)
  commands.setup()
  keymaps.setup()

  -- Set up autocmd for buffer cleanup
  vim.api.nvim_create_autocmd("BufDelete", {
    pattern = config.options.buffer_name,
    callback = function()
      notify.info("Hurl results buffer closed")
    end,
    desc = "Cleanup when Hurl results buffer is deleted",
  })
end

function M.run_hurl_file(options)
  options = options or {}
  local current_file = vim.fn.expand("%:p")

  if not current_file or current_file == "" then
    notify.error("No file is currently open")
    return
  end

  if not current_file:match("%.hurl$") then
    notify.error("Current file is not a .hurl file")
    return
  end

  if vim.fn.filereadable(current_file) ~= 1 then
    notify.error("Current file is not readable: " .. current_file)
    return
  end

  local cmd = "hurl"
  if options.test then
    cmd = cmd .. " --test"
  end
  if options.verbose then
    cmd = cmd .. " --verbose"
  end
  cmd = cmd .. " " .. vim.fn.shellescape(current_file)

  notify.info("Running: " .. cmd)
  local result = vim.fn.system(cmd)
  local exit_code = vim.v.shell_error

  local header = "=== Hurl Results ===\n"
  header = header .. "File: " .. current_file .. "\n"
  header = header .. "Command: " .. cmd .. "\n"
  header = header .. "Exit Code: " .. exit_code .. "\n"
  header = header .. "========================\n\n"

  local full_output = header .. result

  -- Add to history
  local history_entry = {
    timestamp = os.time(),
    file_path = current_file,
    command = cmd,
    result_preview = string.sub(result, 1, 200), -- First 200 chars
    exit_code = exit_code,
    success = exit_code == 0,
  }
  history.add_to_history(history_entry)

  ui.split_and_show_results(full_output)

  if exit_code == 0 then
    notify.info("Hurl execution completed successfully")
  else
    notify.error("Hurl execution failed with exit code: " .. exit_code)
  end
end

function M.run_hurl_test()
  M.run_hurl_file({ test = true })
end

function M.run_hurl_verbose()
  M.run_hurl_file({ verbose = true })
end

function M.run_hurl_test_verbose()
  M.run_hurl_file({ test = true, verbose = true })
end

return M

