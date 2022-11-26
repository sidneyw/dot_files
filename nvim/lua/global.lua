local ok, plenary_reload = pcall(require, "plenary.reload")
if not ok then
	reloader = require
else
	reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return reloader(...)
end

R = function(name)
	RELOAD(name)
	print("Reloaded module:", name)
	return require(name)
end

function nnoremap(lhs, fn)
	vim.keymap.set("n", lhs, fn, { noremap = true })
end

function vnoremap(lhs, fn)
	vim.keymap.set("v", lhs, fn, { noremap = true })
end

function imap(tbl)
	vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

function nmap(tbl)
	vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end
