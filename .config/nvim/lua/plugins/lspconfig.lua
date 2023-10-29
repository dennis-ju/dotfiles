local config = function()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local neodev = require("neodev")
	local keymaps = require("config.keymaps")

	local capabilities = vim.lsp.protocol.make_client_capabilities()

	keymaps.global_lsp()
	-- global keybindings

	local on_attach = function(client, buffer)
		keymaps.buf_lsp(client, buffer)
	end

	lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
		capabilities = capabilities,
		on_attach = on_attach,
	})
	-- Neodev must come before lsp.
	-- Will override lua_ls settings, but only for Neovim config files.
	neodev.setup({})

	-- Dynamic server setup, so we don't have to explicitly list every single server
	-- and can just list the ones we want to override configuration for.
	-- See :help mason-lspconfig-dynamic-server-setup
	mason_lspconfig.setup_handlers({
		function(server)
			lspconfig[server].setup({})
		end,
		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- LuaJIT in the case of Neovim
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							},
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
		["clangd"] = function()
			lspconfig.clangd.setup({
				filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
			})
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	dependencies = {
		"williamboman/mason.nvim",
		"folke/neodev.nvim",
	},
}
