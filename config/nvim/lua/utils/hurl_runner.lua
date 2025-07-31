local wk = require("which-key")
local notify = require("snacks").notify

local M = {}

local HURL_BUFFER_NAME = "*Hurl Results*"

function M.get_or_create_hurl_buffer()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match(HURL_BUFFER_NAME) then
      return buf
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, HURL_BUFFER_NAME)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  return buf
end

function M.split_and_show_results(content)
  local buf = M.get_or_create_hurl_buffer()
  local original_win = vim.api.nvim_get_current_win()

  -- Check if buffer is already visible in any window
  local win_id = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      win_id = win
      break
    end
  end

  -- If not visible, create a split and show the buffer
  if not win_id then
    vim.cmd("split")
    vim.cmd("wincmd j")
    vim.api.nvim_win_set_buf(0, buf)
    win_id = vim.api.nvim_get_current_win()
  end

  -- Update buffer content (switch to results window temporarily)
  local current_win = vim.api.nvim_get_current_win()
  if current_win ~= win_id then
    vim.api.nvim_set_current_win(win_id)
  end

  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "text", { buf = buf })

  -- Return focus to original window
  vim.api.nvim_set_current_win(original_win)
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

  M.split_and_show_results(full_output)

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

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = HURL_BUFFER_NAME,
  callback = function()
    notify.info("Hurl results buffer closed")
  end,
  desc = "Cleanup when Hurl results buffer is deleted",
})

wk.add({
  {
    "<leader>hr",
    function()
      M.run_hurl_file()
    end,
    desc = "Run Hurl file",
  },
  {
    "<leader>ht",
    function()
      M.run_hurl_test()
    end,
    desc = "Run Hurl file (test mode)",
  },
  {
    "<leader>hv",
    function()
      M.run_hurl_verbose()
    end,
    desc = "Run Hurl file (verbose)",
  },
  {
    "<leader>hT",
    function()
      M.run_hurl_test_verbose()
    end,
    desc = "Run Hurl file (test + verbose)",
  },
})

return M
