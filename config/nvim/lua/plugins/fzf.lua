return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- Project files (git_files with fallback to find_files)
      {
        "<leader> ",
        function()
          require("utils.fzf-functions").project_files()
        end,
        desc = "Project files",
      },
      -- Current buffer fuzzy find
      {
        "<leader>q",
        function()
          require("fzf-lua").blines()
        end,
        desc = "Fuzzy find (Buffer)",
      },
      -- Buffers
      {
        "<leader>b",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },
      -- Resume last search
      {
        "<leader>tr",
        function()
          require("fzf-lua").resume()
        end,
        desc = "Resume",
      },
      -- Live grep
      {
        "<leader>z",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Live grep",
      },
      -- Find files (Ctrl-P style)
      {
        "<C-p>",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },
      -- Snippets (luasnip) - custom implementation
      {
        "<leader>se",
        function()
          require("utils.fzf-functions").luasnip_snippets()
        end,
        desc = "Snippets",
      },
      -- Disable unwanted keymaps
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
    opts = {
      -- Window options
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          layout = "flex",
          flip_columns = 120,
        },
      },
      -- Keymaps within fzf picker (matching your telescope mappings)
      keymap = {
        builtin = {
          -- Preview scrolling (builtin previewer)
          ["<C-u>"] = "preview-page-up",
          ["<C-d>"] = "preview-page-down",
          ["<C-f>"] = "preview-page-down",
          ["<C-b>"] = "preview-page-up",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-n"] = "down",
          ["ctrl-p"] = "up",
          ["ctrl-j"] = "down",
          ["ctrl-k"] = "up",
          -- Preview scrolling (fzf native)
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-f"] = "preview-page-down",
          ["ctrl-b"] = "preview-page-up",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      -- Picker-specific options
      git = {
        files = {
          prompt = " ",
        },
      },
      grep = {
        prompt = " ",
      },
      blines = {
        -- sorting_strategy equivalent
        fzf_opts = {
          ["--tac"] = true, -- ascending order
        },
      },
      lsp = {
        symbols = {
          symbol_style = 1,
        },
        code_actions = {
          previewer = "codeaction_native",
        },
      },
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")

      -- Setup fzf-lua
      fzf.setup(opts)

      -- Create user commands (matching telescope commands)
      local commands = {
        { name = "Commits", fn = fzf.git_commits, desc = "Show commits" },
        { name = "Bcommits", fn = fzf.git_bcommits, desc = "Show buffer commits" },
        { name = "Branches", fn = fzf.git_branches, desc = "Show branches" },
        { name = "Marks", fn = fzf.marks, desc = "Show marks" },
        { name = "Colors", fn = fzf.colorschemes, desc = "Show colorschemes" },
        { name = "Keymaps", fn = fzf.keymaps, desc = "Show keymaps" },
      }

      for _, command in pairs(commands) do
        vim.api.nvim_create_user_command(command.name, command.fn, {
          nargs = 0,
          desc = command.desc,
        })
      end

      -- Command abbreviations
      vim.cmd([[ cnoreabbr Fzf FzfLua ]])
      vim.cmd([[ cnoreabbr fzf FzfLua ]])
    end,
  },
}
