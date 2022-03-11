P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

local M = {}

function M.nmap(...)
	vim.api.nvim_set_keymap("n", ...)
end

local function getN(table)
	local n = 0
	print(table)
	for _ in pairs(table) do
		n = n + 1
	end
end

function M.nnoremap(lhs, rhs, userOpts)
	-- local args = ...
	P(lhs)
	P(rhs)
	P(userOpts)

	local opts = userOpts or {}

	opts.noremap = true

	vim.api.nvim_set_keymap("n", lhs, rhs, opts)
end

M.nnoremap("<leader>l", function () print("hello world") end)

return M
