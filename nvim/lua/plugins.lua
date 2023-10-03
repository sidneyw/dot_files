-- vim:foldmethod=marker

vim.cmd([[packadd packer.nvim]])

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")

-- NB: plugins are installed at ~/.local/share/nvim/site/pack/packer/start/

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")

  use("rcarriga/nvim-notify")

  -- Treesitter {{{
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  use({
    -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["as"] = "@statement.outer",
              ["is"] = "@statement.inner",
              ["ad"] = "@comment.outer",
              ["id"] = "@comment.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end
  })

  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-refactor")

  use("towolf/vim-helm")
  -- }}}

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })

  -- tpope {{{
  use("tpope/vim-fugitive")
  use("tpope/vim-repeat")
  use("tpope/vim-rhubarb")
  use("tpope/vim-surround")
  use("tpope/vim-unimpaired")
  use({ "tpope/vim-dispatch" })
  -- use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
  use("tpope/vim-markdown")
  -- }}}

  -- LSP {{{
  use({
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

    },
  })

  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("onsails/lspkind-nvim")
  -- use("nvim-lua/lsp_extensions.nvim")
  -- use("tjdevries/nlua.nvim")
  use("jose-elias-alvarez/null-ls.nvim")

  -- This is a more stable fork of the original plugin commented out below
  use("tami5/lspsaga.nvim")
  -- use({
  --   "glepnir/lspsaga.nvim",
  --   branch = "main",
  --   config = function()
  --     require("lspsaga").init_lsp_saga()
  --   end,
  -- })

  use("simrat39/symbols-outline.nvim")
  -- use("simrat39/rust-tools.nvim")

  use("ray-x/lsp_signature.nvim")

  -- LSP progress bar
  use {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = function()
      require("fidget").setup({
        text = {
          spinner = "arc",
        }
      })
    end,
  }

  use {
    'rmagatti/goto-preview',
    after = "which-key.nvim",
    config = function()
      require('goto-preview').setup {}
      require("which-key").register({
        ["p"] = {
          name = "Goto",
          d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview Definition" },
          t = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Preview Type Definition" },
          i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Preview Implementation" },
          r = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Preview References" },
          P = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close All Preview" },
        },
      }, { prefix = "<localleader>" })
    end
  }
  -- }}}

  -- Go {{{
  use("ray-x/go.nvim")
  use("ray-x/guihua.lua") -- recommanded if need floating window support
  use("edolphin-ydf/goimpl.nvim")
  -- }}}

  -- DAP {{{
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  -- use("Pocco81/DAPInstall.nvim")
  -- use("leoluz/nvim-dap-go")
  -- use("mfussenegger/nvim-dap-python")
  -- }}}

  -- autocomplete {{{

  use("github/copilot.vim")
  -- print out the current timn

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp-document-symbol")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  use("honza/vim-snippets")
  -- }}}

  -- Telescope {{{
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
  use("nvim-telescope/telescope-fzy-native.nvim")
  use("nvim-telescope/telescope-github.nvim")
  use("nvim-telescope/telescope-dap.nvim")
  use("dhruvmanila/telescope-bookmarks.nvim")
  use("benfowler/telescope-luasnip.nvim")

  use("nvim-telescope/telescope-media-files.nvim")
  use({ "LinArcX/telescope-env.nvim" })
  use({ "LinArcX/telescope-ports.nvim" })
  use({ "debugloop/telescope-undo.nvim" })
  -- }}}

  -- Colorscheme {{{
  use({
    "tiagovla/tokyodark.nvim",
    config = function()
      require("tokyodark").setup({
        style = "night",
      })
      -- vim.cmd([[colorscheme tokyodark]])
    end
  })

  use({
    "luisiacc/gruvbox-baby",
    config = function()
      -- make the background darker
      vim.g.gruvbox_baby_background_color = "dark"
      vim.cmd([[colorscheme gruvbox-baby]])
    end
  })

  -- Original gruvbox
  -- use({
  --   "morhetz/gruvbox",
  --   config = function()
  --     vim.g.gruvbox_contrast_dark = "hard"
  --     vim.cmd([[colorscheme gruvbox]])
  --   end,
  -- })
  -- }}}


  -- Use dependency and run lua function after load
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- General {{{
  use("nvim-lualine/lualine.nvim")
  use("kdheepak/tabline.nvim")

  use({
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 200
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
      })
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- remove the current indent level hightlight
      require("ibl").setup({
        indent = {
          char = "┊",
          conceal = true,
        }
      })
    end,
  })

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- Lua
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

      }
    end
  }
  -- }}}
  -- Add indentation guides even on blank lines



  -- Experimental {{{
  use({
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            {
              icon = " ",
              desc = "Update",
              group = "@property",
              action = "PackerSync",
              key = "u"
            },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
          },
        },
      })
    end,
    requires = { "nvim-tree/nvim-web-devicons" },
  })

  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
  })

  -- better input and select box UI
  use({
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup({
        -- Options go here
      })
    end
  })

  use("folke/neodev.nvim")

  -- packer.nvim
  use({
    "robitx/gp.nvim",
    config = function()
      require("gp").setup()
    end,
  })

  -- }}}
end)
