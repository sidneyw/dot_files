-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local cursorpos_augroup = vim.api.nvim_create_augroup("RememberCursorPos", { clear = true })

-- remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = cursorpos_augroup,
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
    end
  end,
})

-- gitcommit
local gitcommit_augroup = vim.api.nvim_create_augroup("gitcommit", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gitcommit_augroup,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

-- yaml
local yaml_augroup = vim.api.nvim_create_augroup("yaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = yaml_augroup,
  pattern = { "*.yml", "*.yaml" },
  callback = function()
    vim.opt_local.filetype = "helm"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = yaml_augroup,
  pattern = { "yaml", "helm" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true -- if you want spaces instead of tabs
  end,
})

-- starlark
local starlark_augroup = vim.api.nvim_create_augroup("starlark", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = starlark_augroup,
  pattern = "*.star",
  callback = function()
    vim.opt_local.filetype = "python"
  end,
})

-- proto
local proto_augroup = vim.api.nvim_create_augroup("proto", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = proto_augroup,
  pattern = "proto",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true -- if you want spaces instead of tabs
  end,
})

-- telescope
local telescope_augroup = vim.api.nvim_create_augroup("telescope", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = telescope_augroup,
  pattern = "TelescopePrompt",
  callback = function()
    require("cmp").setup.buffer({ completion = { autocomplete = false } })
  end,
})