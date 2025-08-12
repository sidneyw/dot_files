local config = require("plugins.hurl.config")

local M = {}

function M.format_execution_header(file_path, command, exit_code)
  local filename = vim.fn.fnamemodify(file_path, ":t")
  local status_icon = exit_code == 0 and "✅ Success" or "❌ Failed"
  local status_color = exit_code == 0 and "DiagnosticOk" or "DiagnosticError"

  local header = {}
  table.insert(header, "🚀 HURL EXECUTION RESULTS")
  table.insert(header, "")
  table.insert(header, "📁 " .. filename)
  table.insert(header, "⚡ " .. command)
  table.insert(header, status_icon .. " (Exit: " .. exit_code .. ")")
  table.insert(header, "")
  table.insert(
    header,
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  )
  table.insert(header, "")

  return table.concat(header, "\n")
end

function M.detect_content_type(content)
  local lines = vim.split(content, "\n")

  -- Look for HTTP response
  local http_start = nil
  for i, line in ipairs(lines) do
    if line:match("^HTTP/") then
      http_start = i
      break
    end
  end

  if http_start then
    -- Find Content-Type header
    for i = http_start, #lines do
      local line = lines[i]
      if line:match("^%s*$") then -- Empty line indicates end of headers
        break
      end
      local content_type = line:match("^[Cc]ontent%-[Tt]ype:%s*([^;]+)")
      if content_type then
        content_type = content_type:lower():gsub("%s+", "")
        if content_type:match("application/json") then
          return "json"
        elseif content_type:match("application/xml") or content_type:match("text/xml") then
          return "xml"
        elseif content_type:match("text/html") then
          return "html"
        elseif content_type:match("text/plain") then
          return "text"
        end
      end
    end
  end

  -- Fallback: analyze content structure
  local body_content = table.concat(lines, "\n")
  if body_content:match("^%s*{") or body_content:match("^%s*%[") then
    return "json"
  elseif body_content:match("^%s*<") then
    return "xml"
  end

  return "http" -- Default for HTTP responses
end

function M.format_content(content, format_type)
  if format_type == "formatted" then
    return M.format_structured(content)
  else
    return content -- raw format
  end
end

local function has_jq()
  return vim.fn.executable("jq") == 1
end

function M.format_structured(content)
  local lines = vim.split(content, "\n")
  local result = {}

  -- Split content into header section and hurl response section
  local separator_index = nil
  for i, line in ipairs(lines) do
    if
      line:match(
        "^━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      )
    then
      separator_index = i
      break
    end
  end

  -- Process header section
  for i = 1, separator_index or #lines do
    local line = lines[i]
    if line:match("🚀 HURL EXECUTION RESULTS") then
      table.insert(result, "# 🚀 HURL EXECUTION RESULTS")
      table.insert(result, "")
    elseif line:match("^📁") or line:match("^⚡") or line:match("^✅") or line:match("^❌") then
      table.insert(result, line)
    elseif
      line:match(
        "^━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      )
    then
      table.insert(result, "---")
      table.insert(result, "")
      break
    end
  end

  -- Process hurl response section (everything after separator)
  if separator_index then
    local hurl_response_lines = {}
    for i = separator_index + 1, #lines do
      if lines[i] and lines[i] ~= "" then -- Skip empty lines right after separator
        table.insert(hurl_response_lines, lines[i])
      end
    end

    if #hurl_response_lines > 0 then
      M.parse_hurl_response(result, hurl_response_lines)
    end
  end

  return table.concat(result, "\n")
end

function M.parse_hurl_response(result, hurl_lines)
  local in_http_headers = false
  local body_lines = {}
  local i = 1

  -- Look for HTTP response line
  while i <= #hurl_lines do
    local line = hurl_lines[i]
    if line:match("^HTTP/") then
      table.insert(result, "## Response")
      table.insert(result, "")
      table.insert(result, "```http")
      table.insert(result, line)
      in_http_headers = true
      i = i + 1
      break
    else
      -- No HTTP response found, treat everything as body content
      table.insert(body_lines, line)
      i = i + 1
    end
  end

  -- Process HTTP headers if we found them
  if in_http_headers then
    while i <= #hurl_lines do
      local line = hurl_lines[i]
      if line:match("^%s*$") then
        -- Empty line marks end of headers
        table.insert(result, "```")
        table.insert(result, "")
        i = i + 1
        break
      else
        -- Add header line
        table.insert(result, line)
        i = i + 1
      end
    end

    -- Collect remaining lines as body
    while i <= #hurl_lines do
      table.insert(body_lines, hurl_lines[i])
      i = i + 1
    end
  end

  -- Process body content
  if #body_lines > 0 then
    M.format_response_body(result, body_lines)
  end
end

function M.format_response_body(result, body_lines)
  local body_content = table.concat(body_lines, "\n")

  table.insert(result, "## Response Body")
  table.insert(result, "")

  -- Check if body content looks like JSON
  local trimmed_body = body_content:match("^%s*(.-)%s*$") or body_content
  if trimmed_body:match("^[%s]*[{%[]") then
    -- Looks like JSON, try to validate and format it
    local ok, decoded = pcall(vim.fn.json_decode, trimmed_body)
    if ok then
      -- Valid JSON - format with jq if available
      table.insert(result, "```json")
      if has_jq() then
        local formatted_json = vim.fn.system("jq .", trimmed_body)
        if vim.v.shell_error == 0 then
          formatted_json = formatted_json:gsub("\n$", "")
          for json_line in formatted_json:gmatch("[^\n]+") do
            table.insert(result, json_line)
          end
        else
          -- jq failed, use original
          for _, body_line in ipairs(body_lines) do
            table.insert(result, body_line)
          end
        end
      else
        -- No jq available, use original
        for _, body_line in ipairs(body_lines) do
          table.insert(result, body_line)
        end
      end
      table.insert(result, "```")
    else
      -- Invalid JSON but looks like it, try anyway with json highlighting
      table.insert(result, "```json")
      for _, body_line in ipairs(body_lines) do
        table.insert(result, body_line)
      end
      table.insert(result, "```")
    end
  else
    -- Not JSON-like, add as plain text
    table.insert(result, "```")
    for _, body_line in ipairs(body_lines) do
      table.insert(result, body_line)
    end
    table.insert(result, "```")
  end
end

function M.cycle_output_format()
  local formats = { "raw", "formatted" }
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

      -- Update filetype based on content detection
      local detected_type = M.detect_content_type(formatted_content)
      local filetype = "text"

      if config.options.output_format == "formatted" then
        filetype = "markdown"
      else
        -- For raw format, use detected content type for better highlighting
        filetype = detected_type or "text"
      end

      vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })

      -- Enable treesitter if available
      pcall(function()
        local ok, ts = pcall(require, "nvim-treesitter.highlight")
        if ok then
          ts.attach(buf, filetype)
        end
      end)
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

  -- Set appropriate filetype based on content detection
  local detected_type = M.detect_content_type(formatted_content)
  local filetype = "text"

  if config.options.output_format == "formatted" then
    filetype = "markdown"
  else
    -- For raw format, use detected content type for better highlighting
    filetype = detected_type or "text"
  end

  vim.api.nvim_set_option_value("filetype", filetype, { buf = buf })

  -- Enable treesitter if available
  pcall(function()
    local ok, ts = pcall(require, "nvim-treesitter.highlight")
    if ok then
      ts.attach(buf, filetype)
    end
  end)

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
