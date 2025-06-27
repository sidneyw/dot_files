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
  -- LSP keymaps and configuration
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "K", vim.lsp.buf.hover }

      keys[#keys + 1] = { "gt", vim.lsp.buf.type_definition }
      keys[#keys + 1] = { "<localleader>dd", ":vsp<cr>:lua vim.lsp.buf.definition()<cr>" }
      keys[#keys + 1] = { "<localleader>R", vim.lsp.buf.rename }

      keys[#keys + 1] = { "gn", function() vim.diagnostic.jump({ count = 1, float = true }) end }
      keys[#keys + 1] = { "gp", function() vim.diagnostic.jump({ count = -1, float = true }) end }

      keys[#keys + 1] = { "gi", require("telescope.builtin").lsp_implementations }
      keys[#keys + 1] = { "gr", require("telescope.builtin").lsp_references }

      -- buf_inoremap({ "<c-s>", vim.lsp.buf.signature_help })

      -- Merge configurations into existing opts
      opts.setup = opts.setup or {}
      opts.setup.eslint = function() end -- Disable eslint formatting

      opts.servers = opts.servers or {}
      opts.servers.vtsls = {
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
            },
          },
        },
      }

      return opts
    end,
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
