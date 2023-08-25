-- Set up nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")


require("luasnip.loaders.from_snipmate").load()

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
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
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Replace },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Replace },
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
    -- Copilot Source
    { name = "copilot", group_index = 2 },
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
        Copilot = "",
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
      -- require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
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

vim.cmd([[
	imap <silent><expr> <C-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : ''
	" -1 for jumping backwards.
	inoremap <silent> <C-j> <cmd>lua require'luasnip'.jump(-1)<Cr>

	snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(1)<Cr>
	snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(-1)<Cr>
]])
