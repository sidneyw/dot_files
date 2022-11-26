local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local function notStarlark(utils)
	-- return false
	P(utils)
	print("notStarlark", utils.root_matches("*envconfig*"))
	return not utils.root_matches("envconfig")
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	debug = false,
	on_attach = function(client)
		if client.name == "gopls" then
			print("GOPLS detected")
			client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
			client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
			return
		end
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
	sources = {
		formatting.prettier,
		-- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.eslint,
		formatting.stylelint,
		diagnostics.tsc,

		formatting.stylua,
		diagnostics.luacheck,

		-- formatting.gofumpt,

		formatting.gofmt,
		formatting.goimports,
		diagnostics.golangci_lint,

		-- formatting.protolint,

		-- formatting.black.with({ condition = notStarlark, extra_args = { "--fast", "--config=~/.config/black" } }),
		-- diagnostics.mypy.with({ condition = notStarlark }),
		-- diagnostics.flake8.with({ condition = notStarlark }),

		-- formatting.rustfmt,
	},
})
