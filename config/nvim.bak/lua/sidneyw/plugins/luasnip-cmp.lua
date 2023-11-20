local cmp = require("cmp")
-- Set up nvim-cmp.
local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_vscode").load()

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Replace }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Replace }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip", option = { use_show_condition = false } },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "treesitter" },
	}, {
		{ name = "buffer", keyword_length = 5 },
	}),
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			mapping = {
				-- Copilot = "",
				buffer = "[Buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				ultisnips = "[Ulti]",
			},
		}),
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- Below is the default comparitor list and order for nvim-cmp
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, -- this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
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
