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
      wk.add({
        { "go", group = "Goto Preview" },
        { "god", gt.goto_preview_definition, desc = "Preview Definition" },
        { "got", gt.goto_preview_type_definition, desc = "Preview Type Definition" },
        { "goi", gt.goto_preview_implementation, desc = "Preview Implementation" },
        { "gor", gt.goto_preview_references, desc = "Preview References" },
        { "<localleader>q", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close All Preview" },
      })
    end,
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "K", vim.lsp.buf.hover }

      keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition }
      keys[#keys + 1] = { "<localleader>dd", ":vsp<cr>:lua vim.lsp.buf.definition()<cr>" }
      keys[#keys + 1] = { "<localleader>R", vim.lsp.buf.rename }

      keys[#keys + 1] = { "gn", vim.diagnostic.goto_next }
      keys[#keys + 1] = { "gp", vim.diagnostic.goto_prev }

      keys[#keys + 1] = { "gi", require("telescope.builtin").lsp_implementations }
      keys[#keys + 1] = { "gr", require("telescope.builtin").lsp_references }

      -- buf_inoremap({ "<c-s>", vim.lsp.buf.signature_help })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Disable eslint formatting as it's slow and timing out on big projects
      setup = {
        eslint = function() end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "eslint-lsp",
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    keys = function()
      return {
        { "<C-\\>", "<cmd>OutlineOpen<CR>", desc = "Symbols Outline" },
      }
    end,
    config = true,
  },
}
