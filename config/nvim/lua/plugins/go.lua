return {
  "ray-x/go.nvim",
  ft = "go",
  keys = {
    { "<localleader>ga", "<cmd>GoAltV<CR>" },
    { "<localleader>gd", "<cmd>GoDebug -n<CR>" },
    { "<localleader>gf", "<cmd>GoFillStruct<CR>" },
    { "<localleader>gt", "<cmd>GoTestFunc<CR>" },
    { "<localleader>gp", "<cmd>GoTestPkg<CR>" },
    { "<localleader>gy", "<cmd>GoAddTag yaml --transform camelcase<CR>" },
  },
  opts = {
    -- gopls_cmd = {install_root_dir .. '/go/gopls'},
    goimport = "gopls", -- if set to 'gopls' will use golsp format
    gofmt = "gopls", -- if set to gopls will use golsp format
    max_line_len = 120,
    tag_transform = "camelcase",
    test_dir = "",
    comment_placeholder = " ",
    icons = { breakpoint = "🛑", currentpos = "📍" }, -- setup to `false` to disable icons setup
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    -- lsp_on_attach = true, -- use on_attach from go.nvim
    dap_debug = true,
    textobjects = true,
    luasnip = false, -- there are some collisions with my own snippets
    lsp_inlay_hints = {
      enable = false,
    },
    build_tags = "integration,cluster_integration",
  },
  config = true,
}
