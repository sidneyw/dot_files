vim.lsp.set_log_level("debug")

local lspconfig = require"lspconfig"
local cmp_nvim_lsp = require"cmp_nvim_lsp"
local lspsaga = require"lspsaga"


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local on_attach = function(--[[ client ]] _, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- TODO(sidneyw): setup same var highlighting either with autocmd below or
  -- with treesitter.

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   vim.api.nvim_exec([[
  --     hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --     hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --     hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
  --     augroup lsp_document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]], false)
  -- end
end

local function withDefaults(opts)
	opts = opts or {}

  opts.capabilities = capabilities
  opts.on_attach = on_attach
  return opts
end


local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/";
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true

    -- TODO: Figure out how to get these to work...
    --  Maybe we need to ship these instead of putting them in `src`?...
    result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

    return result;
end
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- TODO(sidneyw): Change this table to name, opts and move the configuration
-- above into the table
local lang_servers = {
  ["bashls"] = nil,
	-- ["yamlls"] = {
	-- 	settings = {
	-- 		yaml = {
	-- 			schemas = {
	-- 				["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/deploy/**/templates/*.yaml",
	-- 			},
	-- 		},
	-- 	}
	-- },
	["yamlls"] = nil,
  -- "eslint",
  ["gopls"] = {
    cmd = {'gopls'},
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
       },
       staticcheck = true,
      },
    },
  },
  -- "graphql",
  ["tailwindcss"] = nil,
  -- "tsserver",
  ["vimls"] = nil,
  -- ["sumneko_lua"] = {
  --   settings = {
  --     Lua = {
  --       runtime = {
  --         -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
  --         version = "LuaJIT",
  --         -- Setup your lua path
  --         -- path = runtime_path,
  --       },
  --       diagnostics = {
  --         -- Get the language server to recognize the `vim` global
  --         globals = {"vim", "love"},
  --       },
  --       workspace = {
  --         library = get_lua_runtime(),
  --         maxPreload = 10000,
  --         preloadFileSize = 10000,
  --       },
  --     }
  --   },
  -- }
}

for lsp, config in pairs(lang_servers) do
  lspconfig[lsp].setup(withDefaults(config))
end

lspsaga.init_lsp_saga{
  border_style = "round"
}

-- Sets up completion for vim lua runtime variables/methods and allows jumping
-- to vim help via the lsp.
require("nlua.lsp.nvim").setup(lspconfig, {
	cmd = {
		"/Users/sidneyw/tools/sumneko/lua-language-server/bin/lua-language-server",
    "-E",
		"/Users/sidneyw/tools/sumneko/lua-language-server/bin/main.lua"
  },
})

local M = {}

M.goimports = function(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

return M