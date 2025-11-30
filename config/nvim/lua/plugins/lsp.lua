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
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", vim.lsp.buf.hover, desc = "Hover" },
            { "gt", vim.lsp.buf.type_definition, desc = "Type Definition" },
            { "<localleader>dd", ":vsp<cr>:lua vim.lsp.buf.definition()<cr>", desc = "Definition in Split" },
            { "<localleader>R", vim.lsp.buf.rename, desc = "Rename" },
            {
              "gn",
              function()
                vim.diagnostic.jump({ count = 1, float = true })
              end,
              desc = "Next Diagnostic",
            },
            {
              "gp",
              function()
                vim.diagnostic.jump({ count = -1, float = true })
              end,
              desc = "Previous Diagnostic",
            },
            { "gi", require("telescope.builtin").lsp_implementations, desc = "Implementations" },
            { "gr", require("telescope.builtin").lsp_references, desc = "References" },
          },
        },
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
      setup = {
        eslint = function() end, -- Disable eslint formatting
      },
    },
  },
  {
    "mason-org/mason.nvim",
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
