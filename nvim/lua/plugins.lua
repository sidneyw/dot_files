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

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    -- commit = "23dfae4db84f71e2ddb56c024845b322035182ee"
  })

  -- use({
  -- 	-- Additional text objects via treesitter
  -- 	"nvim-treesitter/nvim-treesitter-textobjects",
  -- 	after = "nvim-treesitter",
  -- })

  use("nvim-treesitter/playground")
  use("nvim-treesitter/nvim-treesitter-refactor")
  use("towolf/vim-helm")

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

      -- Useful status updates for LSP
      "j-hui/fidget.nvim",
    },
  })

  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("nvim-lua/lsp_extensions.nvim")
  use("onsails/lspkind-nvim")
  use("tjdevries/nlua.nvim")
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
  -- }}}

  -- Go {{{
  use({
    "ray-x/go.nvim",
    -- TODO: Remove this once go toggle inlay hints issue is fixed
    -- https://github.com/ray-x/go.nvim/issues/342
    -- commit = "ed7e79b9192a13ce189c80c182e897ad1c8c7e29",
  })
  use("ray-x/guihua.lua") -- recommanded if need floating window support
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

  use("edolphin-ydf/goimpl.nvim")

  -- Use dependency and run lua function after load
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  })

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
      require("nvim-autopairs").setup({})
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "┊",
        show_trailing_blankline_indent = false,
      })
    end,
  })
  -- Add indentation guides even on blank lines

  use("honza/vim-snippets")

  vim.cmd([[
		set background=dark
		let g:gruvbox_contrast_dark = 'hard'
		]])

  use("morhetz/gruvbox")

  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

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
            { desc = " Update", group = "@property", action = "PackerSync", key = "u" },
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
  -- }}}
end)
