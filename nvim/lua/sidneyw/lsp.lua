vim.lsp.set_log_level("debug")

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspsaga = require("lspsaga")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local function withDefaults(opts)
	opts = opts or {}

	opts.capabilities = capabilities
	opts.on_attach = function(client)
		-- null ls provides formatting now
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end
	return opts
end

local function get_lua_runtime()
	local result = {}
	for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
		local lua_path = path .. "/lua/"
		if vim.fn.isdirectory(lua_path) then
			result[lua_path] = true
		end
	end

	-- This loads the `lua` files from nvim into the runtime.
	result[vim.fn.expand("$VIMRUNTIME/lua")] = true

	-- TODO: Figure out how to get these to work...
	--  Maybe we need to ship these instead of putting them in `src`?...
	result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

	return result
end
-- local runtime_path = vim.split(package.path, ";")
-- table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.lua")

-- TODO(sidneyw): Change this table to name, opts and move the configuration
-- above into the table
local lang_servers = {
	["bashls"] = {},
	["yamlls"] = {},
	-- "eslint",
	["gopls"] = {
		cmd = { "gopls" },
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
	-- ["tailwindcss"] = {},
	["tsserver"] = {},
	["vimls"] = {},
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

lspsaga.init_lsp_saga({
	border_style = "round",
})

-- Sets up completion for vim lua runtime variables/methods and allows jumping
-- to vim help via the lsp.
require("nlua.lsp.nvim").setup(lspconfig, {
	cmd = {
		"/Users/sidney/.dot_files/tools/lua-language-server/bin/lua-language-server",
		"-E",
		"/Users/sidney/.dot_files/tools/lua-language-server/bin/main.lua",
	},
})
