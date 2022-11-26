-- Set up nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("luasnip.loaders.from_snipmate").load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "luasnip", option = { use_show_condition = false } },
		{ name = "nvim_lsp" },
		{
			name = "copilot",
			-- keyword_length = 0,
			max_item_count = 3,
			trigger_characters = {
				{
					".",
					":",
					"(",
					"'",
					'"',
					"[",
					",",
					"#",
					"*",
					"@",
					"|",
					"=",
					"-",
					"{",
					"/",
					"\\",
					"+",
					"?",
					" ",
				},
			},
			group_index = 2,
		},
		{ name = "nvim_lua" },
		{ name = "treesitter" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 5 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			mapping = {
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				ultisnips = "[Ulti]",
			},
		}),
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		-- Don't start completion for simple commands like :w
		{ name = "cmdline", keyword_length = 2 },
	}),
})

vim.cmd([[
	imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
	" -1 for jumping backwards.
	inoremap <silent> <C-j> <cmd>lua require'luasnip'.jump(-1)<Cr>

	snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(1)<Cr>
	snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(-1)<Cr>
]])
