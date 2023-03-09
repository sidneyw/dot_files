local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
  return
end

-- local saga_action = require("lspsaga.action")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspsaga = require("lspsaga")
local ts_util = require("nvim-lsp-ts-utils")
local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local is_mac = vim.fn.has("macunix") == 1

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

local autocmd = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
  })
end
local autocmd_clear = vim.api.nvim_clear_autocmds

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })

local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format({ async = async, filter = filter })
    end,
  })
end

local filetype_attach = setmetatable({
  -- go = function()
  --  autocmd_format(false)
  -- end,

  scss = function()
    autocmd_format(false)
  end,

  css = function()
    autocmd_format(false)
  end,

  lua = function()
    autocmd_format(false)
  end,

  -- rust = function()
  --  -- telescope_mapper("<space>wf", "lsp_workspace_symbols", {
  --  --   ignore_filename = true,
  --  --   query = "#",
  --  -- }, true)
  --
  --  autocmd_format(false)
  -- end,
  --
  typescript = function()
    autocmd_format(false, function(client)
      return client.name ~= "tsserver"
    end)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local custom_attach = function(client, bufnr)
  local filename = vim.api.nvim_buf_get_name(0)

  if starts_with(filename, "fugitive://") then
    return
  end

  -- uncomment to get current buffer filetype
  -- P(vim.filetype.match({ buf = bufnr }))

  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  buf_inoremap({ "<c-s>", "<cmd>Lspsaga signature_help<CR>" })

  buf_nnoremap({ "go", "<cmd>Lspsaga peek_definition<CR>" })

  -- buf_nnoremap({ "<localleader>R", vim.lsp.buf.rename })
  buf_nnoremap({ "<localleader>R", "<cmd>Lspsaga rename<CR>" })
  buf_nnoremap({ "ga", vim.lsp.buf.code_action })

  buf_nnoremap({ "gd", vim.lsp.buf.definition })
  buf_nnoremap({ "gD", vim.lsp.buf.declaration })
  buf_nnoremap({ "gt", vim.lsp.buf.type_definition })

  buf_nnoremap({ "<localleader>dd", ":vsp<cr>:lua vim.lsp.buf.definition()<cr>" })

  buf_nnoremap({ "gn", "<cmd>Lspsaga diagnostic_jump_next<CR>" })
  buf_nnoremap({ "gp", "<cmd>Lspsaga diagnostic_jump_prev<CR>" })

  buf_nnoremap({ "gi", require("telescope.builtin").lsp_implementations })
  buf_nnoremap({ "gr", require("telescope.builtin").lsp_references })

  -- buf_nnoremap({
  --   "<C-u>",
  --   function()
  --     saga_action.smart_scroll_with_saga(-1)
  --   end,
  -- })

  -- buf_nnoremap({
  --   "<C-d>",
  --   function()
  --     saga_action.smart_scroll_with_saga(1)
  --   end,
  -- })

  if filetype ~= "lua" then
    buf_nnoremap({ "K", "<cmd>Lspsaga hover_doc<CR>" })
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if false and client.server_capabilities.documentHighlightProvider then
    autocmd_clear({ group = augroup_highlight, buffer = bufnr })
    autocmd({ "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr })
    autocmd({ "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr })
  end

  if false and client.server_capabilities.codeLensProvider then
    if filetype ~= "elm" then
      autocmd_clear({ group = augroup_codelens, buffer = bufnr })
      autocmd({ "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true })
      autocmd({ { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr })
    end
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
  require("lsp_signature").on_attach({}, bufnr)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  -- Also uses `shellcheck` and `explainshell`
  bashls = true,

  eslint = true,
  -- graphql = true,
  html = true,
  -- pyright = true,
  vimls = true,
  -- yamlls = true,

  -- TODO: for some reason this is matching protobuf files
  --
  -- clangd = {
  --  cmd = {
  --    "clangd",
  --    "--background-index",
  --    "--suggest-missing-includes",
  --    "--clang-tidy",
  --    "--header-insertion=iwyu",
  --  },
  --  init_options = {
  --    clangdFileStatus = true,
  --  },
  -- },

  omnisharp = {
    cmd = { vim.fn.expand("~/build/omnisharp/run"), "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  },

  cssls = true,

  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)

      ts_util.setup({ auto_inlay_hints = false })
      ts_util.setup_client(client)
    end,
  },
}

-- local rust_analyzer_cmd = { "rustup", "run", "nightly", "rust-analyzer" }
local has_rt, rt = pcall(require, "rust-tools")
if has_rt then
  local extension_path = vim.fn.expand("~/.vscode/extensions/sadge-vscode/extension/")
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

  rt.setup({
    server = {
      on_init = custom_init,
      on_attach = custom_attach,
      capabilities = updated_capabilities,
      flags = {
        debounce_text_changes = nil,
      },
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
    tools = {
      inlay_hints = {
        auto = true,
      },
    },
  })
end

local has_go, go = pcall(require, "go")
if has_go then
  go.setup({
    -- gopls_cmd = {install_root_dir .. '/go/gopls'},
    goimport = "gopls", -- if set to 'gopls' will use golsp format
    gofmt = "gopls", -- if set to gopls will use golsp format
    max_line_len = 120,
    tag_transform = "camelcase",
    test_dir = "",
    comment_placeholder = " ",
    icons = { breakpoint = "🛑", currentpos = "📍" }, -- setup to `false` to disable icons setup
    lsp_cfg = {
      -- on_init = custom_init,
      capabilities = updated_capabilities,
      on_attach = custom_attach,
    },
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = true, -- use on_attach from go.nvim
    dap_debug = true,
    textobjects = false,
    luasnip = false, -- there are some collisions with my own snippets
    build_tags = "integration,cluster_integration",
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require("go.format").goimport()
    end,
    group = format_sync_grp,
  })

  nnoremap("<localleader>ga", "<cmd>GoAltV!<CR>")
  nnoremap("<localleader>gd", "<cmd>GoDebug -n<CR>") -- launch debugger for the nearest test function
  nnoremap("<localleader>gs", "<cmd>GoDebug -s<CR>") -- stop the debug session and unmap keys
  nnoremap("<localleader>gf", "<cmd>GoFillStruct<CR>")
  nnoremap("<localleader>gt", "<cmd>GoTestFunc<CR>")
  nnoremap("<localleader>gy", "<cmd>GoAddTag yaml --transform camelcase<CR>")
  -- Force the dap keymaps to unbind
  -- lua require("go.dap").stop(true)
else
  -- fallback to the regular lsp implementation
  servers.gopls = {
    settings = {
      gopls = {
        buildFlags = { "-tags=cluster_integration" },
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
      codelenses = { test = true },
    },
    flags = {
      debounce_text_changes = 200,
    },
  }
end

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

local sumneko_cmd, sumneko_env = nil, nil
-- require("nvim-lsp-installer").setup({
--   automatic_installation = false,
--   ensure_installed = { "sumneko_lua", "gopls", "bashls", "yamlls" },
-- })
--
require("mason").setup()

-- Enable the following language servers
require("mason-lspconfig").setup({
  ensure_installed = {
    "rust_analyzer",
    "pyright",
    "eslint",
    "cssls",
    "tsserver",
    "lua_ls",
    "gopls",
    "bashls",
    "yamlls",
  },
})

-- sumneko_cmd = {
--   vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server",
-- }

-- sumneko_env = {
--   cmd_env = {
--     PATH = process.extend_path({
--       path.concat({ vim.fn.stdpath("data"), "lsp_servers", "sumneko_lua", "extension", "server", "bin" }),
--     }),
--   },
-- }

-- setup_server("sumneko_lua", {
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = {
--           -- vim
--           "vim",
--
--           -- Busted
--           "describe",
--           "it",
--           "before_each",
--           "after_each",
--           "teardown",
--           "pending",
--           "clear",
--
--           -- Colorbuddy
--           "Color",
--           "c",
--           "Group",
--           "g",
--           "s",
--
--           -- Custom
--           "RELOAD",
--         },
--       },
--
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--         checkThirdParty = false,
--       },
--     },
--   },
-- })

for server, config in pairs(servers) do
  setup_server(server, config)
end

local use_null = true
if use_null then
  null_ls.setup({
    sources = {
      formatting.stylelint,
      diagnostics.tsc,

      formatting.stylua,
      diagnostics.luacheck,

      -- null_ls.builtins.formatting.prettierd,
      -- formatting.gofmt,
      -- formatting.goimports,
      diagnostics.golangci_lint,
    },
  })
end

vim.cmd([[
  let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
]])

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
