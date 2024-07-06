local function nnoremap(lhs, fn, opts)
  local default_opts = {
    noremap = true,
  }

  if opts then
    default_opts = vim.tbl_extend("force", default_opts, opts)
  end

  vim.keymap.set("n", lhs, fn, { noremap = true })
end

local function vnoremap(lhs, fn)
  vim.keymap.set("v", lhs, fn, { noremap = true })
end

function imap(tbl)
  vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

local function nmap(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

return {
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({})
      local wk = require("which-key")
      local gt = require("goto-preview")
      wk.register({
        ["go"] = {
          name = "Goto Preview",
          d = { gt.goto_preview_definition, "Preview Definition" },
          t = { gt.goto_preview_type_definition, "Preview Type Definition" },
          i = { gt.goto_preview_implementation, "Preview Implementation" },
          r = { gt.goto_preview_references, "Preview References" },
        },
        ["<localleader>q"] = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close All Preview" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {},
      },
    },
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          local filename = vim.api.nvim_buf_get_name(0)

          if starts_with(filename, "fugitive://") then
            return
          end

          local filetype = vim.api.nvim_buf_get_option(0, "filetype")
          buf_nnoremap({ "<localleader>R", vim.lsp.buf.rename })
          buf_nnoremap({ "ga", vim.lsp.buf.code_action })

          buf_nnoremap({ "gd", vim.lsp.buf.definition })
          buf_nnoremap({ "gD", vim.lsp.buf.declaration })
          buf_nnoremap({ "gt", vim.lsp.buf.type_definition })

          buf_nnoremap({ "<localleader>dd", ":vsp<cr>:lua vim.lsp.buf.definition()<cr>" })

          buf_nnoremap({ "gn", vim.diagnostic.goto_next })
          buf_nnoremap({ "gp", vim.diagnostic.goto_prev })

          buf_nnoremap({ "gi", require("telescope.builtin").lsp_implementations })
          buf_nnoremap({ "gr", require("telescope.builtin").lsp_references })
          buf_inoremap({ "<c-s>", vim.lsp.buf.signature_help })

          if filetype ~= "lua" then
            buf_nnoremap({ "K", vim.lsp.buf.hover })
          end
        end)
      end,
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "deno",
      },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = function()
      return {
        { "<C-\\>", "<cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
      }
    end,
    config = true,
    cmd = { "SymbolsOutline" },
  },
}
