vim.cmd([[packadd packer.nvim]])

local has = function(x)
	return vim.fn.has(x) == 1
end

local is_mac = has("macunix")

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	use("rcarriga/nvim-notify")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
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
	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })
	use("tpope/vim-markdown")
	-- }}}

	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	-- LSP {{{
	use("neovim/nvim-lspconfig")
	if is_mac then
		use("williamboman/nvim-lsp-installer")
	end

	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("nvim-lua/lsp_extensions.nvim")
	use("onsails/lspkind-nvim")
	use("tjdevries/nlua.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	use("tami5/lspsaga.nvim")
	use("simrat39/symbols-outline.nvim")
	use({
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	})

	use({
		"folke/lsp-trouble.nvim",
		cmd = "Trouble",
		config = function()
			-- Can use P to toggle auto movement
			require("trouble").setup({
				auto_preview = false,
				auto_fold = true,
			})
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
		end,
	})
	-- }}}

	-- DAP {{{
	use("mfussenegger/nvim-dap")
	use("Pocco81/DAPInstall.nvim")
	use("leoluz/nvim-dap-go")
	use("theHamsta/nvim-dap-virtual-text")
	use("mfussenegger/nvim-dap-python")
	use("rcarriga/nvim-dap-ui")
	-- }}}

	-- autocomplete {{{
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
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-github.nvim")
	use("nvim-telescope/telescope-dap.nvim")
	use("dhruvmanila/telescope-bookmarks.nvim")
	use("benfowler/telescope-luasnip.nvim")
	-- }}}

	use("edolphin-ydf/goimpl.nvim")

	-- Use dependency and run lua function after load
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use("sudormrfbin/cheatsheet.nvim")

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
end)