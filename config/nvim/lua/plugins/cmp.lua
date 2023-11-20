-- Set up nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_vscode").load()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.mapping = cmp.mapping.preset.insert({
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
      })
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
    end,
  },
}
