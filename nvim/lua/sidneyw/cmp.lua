-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local lspkind = require('lspkind')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  enabled = true,
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),

    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<C-k>"] = cmp.mapping(
      function (fallback)
        cmp_ultisnips_mappings.compose({ "expand", "jump_forwards" })(fallback)
      end
    ),

    ["<C-j>"] = cmp.mapping(
      function (fallback)
        cmp_ultisnips_mappings.compose({ "jump_backwards" })(fallback)
      end
    ),
  },

  sources = {
    { name = 'ultisnips' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
    -- { name = 'cmp_tabnine' },
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      mapping = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        ultisnips = "[Ulti]",
      },
    }
  },
}
