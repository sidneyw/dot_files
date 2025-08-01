local M = {}

M.defaults = {
  buffer_name = "*Hurl Results*",
  split_direction = "horizontal", -- horizontal, vertical, floating
  output_format = "raw", -- raw, json, formatted
  auto_save = false,
  save_directory = vim.fn.stdpath("cache") .. "/hurl",
  max_history_entries = 100,
}

M.options = {}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

  -- Ensure save directory exists if auto_save is enabled
  if M.options.auto_save then
    vim.fn.mkdir(M.options.save_directory, "p")
  end
end

return M

