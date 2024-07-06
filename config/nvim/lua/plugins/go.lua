return {
  {
    "ray-x/go.nvim",
    ft = "go",
    keys = {
      { "<localleader>ga", "<cmd>GoAltV<CR>" },
      { "<localleader>gd", "<cmd>GoDebug -n<CR>" },
      { "<localleader>gs", "<cmd>GoDebug -s<CR>" },
      { "<localleader>gf", "<cmd>GoFillStruct<CR>" },
      { "<localleader>gt", "<cmd>GoTestFunc<CR>" },
      { "<localleader>gp", "<cmd>GoTestPkg<CR>" },
      { "<localleader>gy", "<cmd>GoAddTag yaml --transform camelcase<CR>" },
    },
    dependencies = {
      "ray-x/guihua.lua",
    },
    opts = {
      -- gopls_cmd = {install_root_dir .. '/go/gopls'},
      fillstruct = "gopls", -- set to fillstruct if gopls fails to fill struct
      max_line_len = 120,
      tag_transform = "camelcase",
      test_dir = "",
      comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. 󰟓       
      icons = { breakpoint = "🛑", currentpos = "📍" }, -- setup to `false` to disable icons setup
      lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
      lsp_codelens = false, -- set to false to disable codelens, true by default, you can use a function
      lsp_document_formatting = false,
      -- lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
      lsp_on_attach = nil, -- use on_attach from go.nvim
      dap_debug = true,
      textobjects = true,
      luasnip = true, -- there are some collisions with my own snippets
      lsp_inlay_hints = {
        enable = false,
      },
      build_tags = "cluster_integration",
    },
    -- config = true,
    config = function(opts)
      local go = require("go")
      go.setup(opts)

      local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
  },
}
