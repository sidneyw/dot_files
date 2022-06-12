local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local function notStarlark(utils)
	return false
	-- return not utils.root_has_file("config_allowlist.yml")
end

null_ls.setup({
	debug = false,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
					augroup LspFormatting
							autocmd! * <buffer>
							autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1500)
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

		formatting.black.with({ extra_args = { "--fast", "--config=~/.config/black" } }),
		diagnostics.mypy.with({ conditions = notStarlark }),
		diagnostics.flake8.with({ conditions = notStarlark }),

		-- formatting.rustfmt,
	},
})
