local actions = require("telescope.actions")

local symbols = {
  telescope = "",
  github = "",
  git = "",
  open_folder = "",
  file = "",
}

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disbale unwanted keymaps
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      pickers = {
        git_files = {
          prompt_prefix = symbols.git .. " ",
        },
        current_buffer_fuzzy_find = {
          sorting_strategy = "ascending",
          -- theme = "ivy",
        },
        live_grep = {
          path_display = { "smart" },
          prompt_prefix = symbols.telescope .. " ",
        },
        lsp_implementations = {
          theme = "ivy",
          initial_mode = "normal",
        },
        lsp_references = {
          theme = "ivy",
          initial_mode = "normal",
        },
        fname_width = 55,
        luasnip = {
          layout_strategy = "vertical",
          layout_config = {
            vertical = { width = 100, height = 80 },
          },
          theme = "dropdown",
          initial_mode = "normal",
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
        bookmarks = {
          -- Available: 'brave', 'google_chrome', 'safari', 'firefox'
          selected_browser = "brave",

          -- Either provide a shell command to open the URL
          url_open_command = "open",

          -- Or provide the plugin name which is already installed
          -- Available: 'vim_external', 'open_browser'
          url_open_plugin = nil,

          -- Show the full path to the bookmark instead of just the bookmark name
          full_path = true,

          -- Provide a custom profile name for Firefox
          firefox_profile_name = nil,
        },
        undo = {
          side_by_side = true,
          layout_strategy = "vertical",
          layout_config = {
            preview_height = 0.8,
          },
        },
      },
    },
    config = function(_, opts)
      local custom_telescope = require("../utils/telescope-functions")

      local builtin = require("telescope.builtin")

      vim.cmd([[ cnoreabbr Tele Telescope ]])
      vim.cmd([[ cnoreabbr tele Telescope ]])

      local utils = {
        { name = "Commits", fn = builtin.git_commits, desc = "Show commits" },
        { name = "Bcommits", fn = builtin.git_bcommits, desc = "Show buffer commits" },
        { name = "Branches", fn = builtin.git_branches, desc = "Show branches" },
        { name = "Marks", fn = builtin.marks, desc = "Show marks" },
        { name = "Colors", fn = builtin.colorscheme, desc = "Show colorschemes" },
        { name = "Keymaps", fn = builtin.keymaps, desc = "Show keymaps" },
      }

      for _, command in pairs(utils) do
        vim.api.nvim_create_user_command(command.name, command.fn, {
          nargs = 0,
          desc = command.desc,
        })
      end

      require("which-key").register({
        ["<C-p>"] = { builtin.find_files, "Find files" },
        ["<leader>f"] = { custom_telescope.project_files, "Project files" },
        ["<leader>a"] = { builtin.live_grep, "Live grep" },
        ["<leader>q"] = { builtin.current_buffer_fuzzy_find, "Fuzzy find" },
        ["<leader>s"] = { builtin.lsp_document_symbols, "LSP document symbols" },
        ["<leader>b"] = { builtin.buffers, "Buffers" },
        ["<leader>hl"] = { builtin.help_tags, "Help tags" },
        ["<leader>m"] = { builtin.oldfiles, "Old files" },
        ["<leader>tr"] = { builtin.resume, "Resume" },
      })

      require("telescope").setup(opts)
    end,
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "nvim-telescope/telescope-github.nvim",
    config = function()
      require("telescope").load_extension("gh")
    end,
  },
  {
    "dhruvmanila/telescope-bookmarks.nvim",
    config = function()
      require("telescope").load_extension("bookmarks")
    end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      require("telescope").load_extension("media_files")
    end,
  },
  {
    "nvim-telescope/telescope-cheat.nvim",
    config = function()
      require("telescope").load_extension("cheat")
    end,
  },
}
