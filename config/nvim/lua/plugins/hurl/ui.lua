local config = require("plugins.hurl.config")

local M = {}

function M.format_content(content, format_type)
  if format_type == "json" then
    return M.format_as_json(content)
  elseif format_type == "formatted" then
    return M.format_structured(content)
  else
    return content -- raw format
  end
end

local function has_jq()
  return vim.fn.executable("jq") == 1
end

function M.format_as_json(content)
  -- Try to extract JSON from the response body
  local lines = vim.split(content, "\n")
  local json_start = nil
  local formatted_lines = {}

  for i, line in ipairs(lines) do
    table.insert(formatted_lines, line)

    -- Look for JSON content (usually after empty line following headers)
    if line:match("^%s*{") or line:match("^%s*%[") then
      json_start = i
      break
    end
  end

  if json_start then
    -- Extract potential JSON content
    local json_lines = {}
    for i = json_start, #lines do
      table.insert(json_lines, lines[i])
    end

    local json_text = table.concat(json_lines, "\n")

    -- Use jq for perfect JSON formatting if available
    if has_jq() then
      local formatted_json = vim.fn.system("jq .", json_text)
      if vim.v.shell_error == 0 then
        -- Rebuild the content with jq-formatted JSON
        local result = {}
        for i = 1, json_start - 1 do
          table.insert(result, formatted_lines[i])
        end
        table.insert(result, "\n--- Pretty JSON ---")
        -- Remove trailing newline from jq output
        formatted_json = formatted_json:gsub("\n$", "")
        for line in formatted_json:gmatch("[^\n]+") do
          table.insert(result, line)
        end

        return table.concat(result, "\n")
      end
    end

    -- Fallback: check if it's valid JSON and show a message
    local ok, decoded = pcall(vim.fn.json_decode, json_text)
    if ok then
      local result = {}
      for i = 1, json_start - 1 do
        table.insert(result, formatted_lines[i])
      end
      table.insert(result, "\n--- JSON Content (install jq for pretty formatting) ---")
      table.insert(result, json_text)

      return table.concat(result, "\n")
    end
  end

  return content -- Return original if no JSON found or parsing failed
end

function M.format_structured(content)
  local lines = vim.split(content, "\n")
  local result = {}
  local in_headers = false
  local in_body = false

  for _, line in ipairs(lines) do
    if line:match("^=== Hurl Results ===") then
      table.insert(
        result,
        "╭─────────────────────────────────────────╮"
      )
      table.insert(result, "│           🌐 HURL RESULTS               │")
      table.insert(
        result,
        "╰─────────────────────────────────────────╯"
      )
    elseif line:match("^File:") or line:match("^Command:") or line:match("^Exit Code:") then
      table.insert(result, "📋 " .. line)
    elseif line:match("^========================") then
      table.insert(
        result,
        "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      )
    elseif line:match("^HTTP/") then
      table.insert(result, "🔗 " .. line)
      in_headers = true
    elseif line:match("^%s*$") and in_headers then
      table.insert(result, "")
      in_headers = false
      in_body = true
    elseif in_headers and line:match(":") then
      table.insert(result, "📝 " .. line)
    elseif in_body then
      table.insert(result, line)
    else
      table.insert(result, line)
    end
  end

  return table.concat(result, "\n")
end

function M.cycle_output_format()
  local formats = { "raw", "json", "formatted" }
  local current = config.options.output_format
  local current_index = 1

  for i, format in ipairs(formats) do
    if format == current then
      current_index = i
      break
    end
  end

  local next_index = (current_index % #formats) + 1
  config.options.output_format = formats[next_index]

  vim.notify("Hurl output format: " .. config.options.output_format)

  -- If results buffer is visible, refresh it with new format
  M.refresh_results_buffer()
end

function M.refresh_results_buffer()
  local buffer_name = config.options.buffer_name
  local buf = nil

  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(b) and vim.api.nvim_buf_get_name(b):match(buffer_name) then
      buf = b
      break
    end
  end

  if buf then
    -- Get the raw content stored in buffer variable
    local raw_content = vim.b[buf].hurl_raw_content
    if raw_content then
      local formatted_content = M.format_content(raw_content, config.options.output_format)
      vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(formatted_content, "\n"))
      vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

      -- Update filetype
      local filetype = config.options.output_format == "json" and "json" or "text"
      vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })
    end
  end
end

function M.get_or_create_hurl_buffer()
  local buffer_name = config.options.buffer_name

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf):match(buffer_name) then
      return buf
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, buffer_name)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  return buf
end

function M.split_and_show_results(content)
  local buf = M.get_or_create_hurl_buffer()
  local original_win = vim.api.nvim_get_current_win()

  -- Format content according to current output format
  local formatted_content = M.format_content(content, config.options.output_format)

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
    if config.options.split_direction == "vertical" then
      vim.cmd("vsplit")
      vim.cmd("wincmd l")
      vim.api.nvim_win_set_buf(0, buf)
      win_id = vim.api.nvim_get_current_win()
    elseif config.options.split_direction == "floating" then
      M.create_floating_window(buf)
      win_id = vim.api.nvim_get_current_win()
    else
      vim.cmd("split")
      vim.cmd("wincmd j")
      vim.api.nvim_win_set_buf(0, buf)
      win_id = vim.api.nvim_get_current_win()
    end
  end

  -- Update buffer content (switch to results window temporarily)
  local current_win = vim.api.nvim_get_current_win()
  if current_win ~= win_id then
    vim.api.nvim_set_current_win(win_id)
  end

  -- Store raw content for format cycling
  vim.b[buf].hurl_raw_content = content

  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(formatted_content, "\n"))
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  -- Set appropriate filetype based on format
  local filetype = "text"
  if config.options.output_format == "json" then
    filetype = "json"
  end
  vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })

  -- Return focus to original window
  vim.api.nvim_set_current_win(original_win)
end

function M.create_floating_window(buf)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " Hurl Results ",
    title_pos = "center",
  }

  vim.api.nvim_open_win(buf, true, opts)
end

return M

