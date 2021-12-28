local actions = require("telescope.actions")
local telescope = require("telescope")
local themes = require("telescope.themes")

require("telescope").setup({
    defaults = {
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },

        layout_strategy = "flex",

        mappings = {
          i = {
            ["<C-n>"] = false,
            ["<C-p>"] = false,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          }
        },
    },
    pickers = {
      current_buffer_fuzzy_find = {
        sorting_strategy = "ascending",
        -- theme = "ivy",
      },
      live_grep = {
        path_display = "truncate"
      },
    },
    extensions = {
      -- fzy_native = {
      --     override_generic_sorter = false,
      --     override_file_sorter = true,
      -- },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
})

-- require("telescope").load_extension("git_worktree")
telescope.load_extension("fzf")
-- telescope.load_extension("fzy_native")
telescope.load_extension('gh')
-- telescope.load_extension('coc')
telescope.load_extension('ultisnips')
telescope.load_extension('dap')
telescope.load_extension("notify")

local M = {}

M.project_files = function(opts)
  opts = opts or {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

M.implementations = function(opts)
  opts = opts or {}
  local themed_opts = themes.get_ivy(opts)
  -- telescope.extensions.coc.implementations(themed_opts)
	require"telescope.builtin".lsp_implementations(themed_opts)
end

M.references = function(opts)
  opts = opts or {}
  local themed_opts = themes.get_ivy(opts)
  -- telescope.extensions.coc.references(themed_opts)
	require"telescope.builtin".lsp_references(themed_opts)
end

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "<Dot Files Search>",
        cwd = "~/.dot_files",
        hidden = true,
    })
end

return M
