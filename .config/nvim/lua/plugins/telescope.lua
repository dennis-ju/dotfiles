local config = function()
  require("telescope").setup({
    defaults = {
      layout_strategy = "vertical",
      layout_config = { height = 0.95, },
    },
    pickers = {
      find_files = {
	hidden = true
      },
    }
  })

  require('telescope').load_extension('fzf')

end

return {
    'nvim-telescope/telescope.nvim',
     dependencies = { 
	'nvim-lua/plenary.nvim',
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	"nvim-treesitter/nvim-treesitter",
    },
    config = config,
    keys = require("config.keymaps").telescope,
    cmd = "Telescope",
    event = { "BufReadPre", "BufNewFile" },
}
