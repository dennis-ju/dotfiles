local opts = {
	ensure_installed = {
		"clangd",
		"lua_ls",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = "williamboman/mason.nvim",
}
