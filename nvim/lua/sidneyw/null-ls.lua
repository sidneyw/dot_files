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

null_ls.setup({
	debug = false,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
					augroup LspFormatting
							autocmd! * <buffer>
							autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)
					augroup END
					]])
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

		formatting.gofmt,
		-- formatting.gofumpt,
		formatting.goimports,
		diagnostics.golangci_lint,

		formatting.protolint,

		-- formatting.black.with({ condition = notStarlark, extra_args = { "--fast", "--config=~/.config/black" } }),
		-- diagnostics.mypy.with({ condition = notStarlark }),
		-- diagnostics.flake8.with({ condition = notStarlark }),

		-- formatting.rustfmt,
	},
})
