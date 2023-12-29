
-- Keymaps that are sent to plugins during configuration
-- Return a module here so we can keep all keymap definitions
-- in the same place.
-- This is only for global keys, other contexts
-- (such as in the cmp selection menu) may be defined
-- in their respective files.
local M = {}


-- Wrap it in a function to prevent requiring this file evaluates
-- global keymaps multiple times.

M.telescope = {
  {"<leader>tf", function() require('telescope.builtin').find_files() end, silent = true, desc = "Find in files"},
  {"<leader>tg", function() require('telescope.builtin').grep_string() end, silent = true, desc = "Search for selected string"},
  {"<leader>tl", function() require('telescope.builtin').live_grep() end, silent = true, desc = "Search for string"},
  {"<leader>tk", function() require('telescope.builtin').keymaps() end, silent = true, desc = "Show normal mode keymaps"},
  {"<leader>tb", function() require('telescope.builtin').buffers() end, silent = true, desc = "Show open buffers"},
  {"<leader>tr", function() require('telescope.builtin').lsp_references() end, silent = true, desc = "Show references to current symbol"},
  {"<leader>ts", function() require('telescope.builtin').lsp_document_symbols() end, silent = true, desc = "Show all functions"},
}

M.neogit = {
  {"gs", function() require('neogit').open() end, silent = true, desc = "Open neogit"},
}

M.lazygit = {
  {"<leader>gg", function() require('lazygit').lazygit() end, silent = true, desc = "Open lazygit"},
}

M.global_lsp = function()
	local map = vim.keymap.set
	map("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
	map("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Prev diagnostic" })
end

M.buf_lsp = function(_, buffer)
	local map = vim.keymap.set
	-- FIXME there are other cool possibilities listed in nvim-lspconfig
	map("n", "<localleader>D", vim.lsp.buf.declaration, { silent = true, buffer = buffer, desc = "Declaration" })
	map("n", "<localleader>d", vim.lsp.buf.definition, { silent = true, buffer = buffer, desc = "Definition" })
	-- map(
	-- 	"n",
	-- 	"<localleader>d",
	-- 	":TroubleToggle lsp_definitions<CR>",
	-- 	{ silent = true, buffer = buffer, desc = "Definitions" }
	-- )
	map("n", "<localleader>r", vim.lsp.buf.references, { silent = true, buffer = buffer, desc = "References" })
	-- map(
	-- 	"n",
	-- 	"<localleader>r",
	-- 	":TroubleToggle lsp_references<CR>",
	-- 	{ silent = true, buffer = buffer, desc = "References" }
	-- )
	map("n", "<localleader>i", vim.lsp.buf.implementation, { silent = true, buffer = buffer, desc = "Implementation" })
	map(
		"n",
		"<localleader>t",
		vim.lsp.buf.type_definition,
		{ silent = true, buffer = buffer, desc = "Type definition" }
	)
	map("n", "<localleader>h", vim.lsp.buf.hover, { silent = true, buffer = buffer, desc = "Hover" })
	map("n", "<localleader>s", vim.lsp.buf.signature_help, { silent = true, buffer = buffer, desc = "Signature help" })
	map("n", "<localleader>x", vim.lsp.buf.code_action, { silent = true, buffer = buffer, desc = "Code action" })
	-- map("n", prefix .. "l", "<cmd>lua vim.diagnostic.open_float({ focusable = false })<CR>")
	map("n", "<localleader>R", vim.lsp.buf.rename, { silent = true, buffer = buffer, desc = "Rename" })
	map("n", "<localleader>I", vim.lsp.buf.incoming_calls, { silent = true, buffer = buffer, desc = "Incoming calls" })
	map("n", "<localleader>O", vim.lsp.buf.outgoing_calls, { silent = true, buffer = buffer, desc = "Outgoing calls" })
end

M.gitsigns = function(buffer)
	local gitsigns = package.loaded.gitsigns
	local map = vim.keymap.set

	map("n", "]h", gitsigns.next_hunk, { silent = true, buffer = buffer, desc = "Next hunk" })
	map("n", "[h", gitsigns.prev_hunk, { silent = true, buffer = buffer, desc = "Prev hunk" })
	map("n", "<leader>hs", gitsigns.stage_hunk, { silent = true, buffer = buffer, desc = "Stage hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { silent = true, buffer = buffer, desc = "Reset hunk" })
	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { silent = true, buffer = buffer, desc = "Stage hunk" })
	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { silent = true, buffer = buffer, desc = "Reset hunk" })
	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { silent = true, buffer = buffer, desc = "Blame hunk" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { silent = true, buffer = buffer, desc = "Preview Hunk" })
end

return M
