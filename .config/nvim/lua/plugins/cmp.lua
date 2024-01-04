local function in_comment()
	local context = require("cmp.config.context")
	return context.in_treesitter_capture("comment") or context.in_syntax_group("Comment")
end

local function in_string()
	local context = require("cmp.config.context")
	return context.in_treesitter_capture("string") or context.in_syntax_group("String")
end

local function in_spell()
	local context = require("cmp.config.context")
	return context.in_treesitter_capture("spell")
end

local function disallowed_buftype()
	local buftype = vim.bo.buftype
	local disallowed = {
		"prompt",
		"nofile",
	}
	for _, v in pairs(disallowed) do
		if buftype == v then
			return true
		end
	end
	return false
end

local function config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
  local luasnip = require("luasnip")

	cmp.setup({
		enabled = function()
			return not in_comment() and not disallowed_buftype()
		end,
		mapping = {
			["<C-e>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-a>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<Esc>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<Tab>"] = cmp.mapping.confirm({ select = true }),
		},
  	snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
      {
				name = "luasnip",
				group_index = 1,
				entry_filter = function()
					return not in_string()
				end,
			},
			{
				name = "nvim_lsp",
				group_index = 2,
        max_item_count = 5
			},
			{
				name = "nvim_lua",
				group_index = 3,
        max_item_count = 5
			},
			{
				name = "spell",
				option = {
					enable_in_context = in_spell,
				},
				group_index = 3,
			},
			{
				name = "async_path",
				group_index = 4,
        max_item_count = 5
			},
			{
				name = "calc",
				group_index = 4,
        max_item_count = 5
			},
			{
				name = "buffer",
				keyword_length = 3,
				group_index = 5,
        max_item_count = 5
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				ellipsis_char = "…",
				menu = {
					luasnip = "[SNIP]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					beancount = "[BEAN]",
					spell = "[SPELL]",
					async_path = "[PATH]",
					buffer = "[BUF]",
					calc = "[CALC]",
				},
			}),
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	})

	cmp.setup.cmdline("/", {
    sources = {
      {
        name = "buffer",
      },
    },
    view = {
      entries = {name = 'wildmenu', separator = '|' }
    },
	})
end

return {
	{
		"hrsh7th/nvim-cmp",
		config = config,
		dependencies = {
			"FelipeLema/cmp-async-path",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim",
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
		},
		event = "InsertEnter",
	},
}
