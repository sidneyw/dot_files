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
      {
        "<leader> ",
        require("../utils/telescope-functions").project_files,
        desc = "Project files",
      },
      {
        "<leader>q",
        require("telescope.builtin").current_buffer_fuzzy_find,
        desc = "Fuzzy find (Buffer)",
      },
      { "<leader>b", require("telescope.builtin").buffers, desc = "Buffers" },
      { "<leader>tr", require("telescope.builtin").resume, desc = "Resume" },
      { "<leader>z", require("telescope.builtin").live_grep },
      {
        "<leader>se",
        function()
          require("telescope").extensions.luasnip.luasnip()
        end,
        desc = "Snippets",
      },
      { "<C-p>", require("telescope.builtin").find_files, desc = "Find files" },
      -- disable unwanted keymaps
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
    opts = {
      defaults = {
        -- sorting_strategy = "ascending",
        layout_strategy = "flex",
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
