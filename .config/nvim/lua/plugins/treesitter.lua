local config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"lua",
			"bash",
      "python",
		},
		auto_install = true,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = config,
	build = ":TSUpdate",
	cmd = { "TSUpdate" },
	event = { "BufReadPre", "BufNewFile" },
}
