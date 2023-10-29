local opt = vim.opt

opt.tabstop = 2 -- tabs width
opt.softtabstop = 2 -- when hitting tab or backspace, how wide should a tab be
opt.shiftwidth = 2 -- auto indent amount when using indents ex << and >>
opt.expandtab = true -- no real tabs
opt.smarttab = true -- insert tabs on the start according to shiftwidth, not tabstop
opt.autoindent = true -- keep indenting after newline 
opt.shiftround = true -- when at 3 spaces, and I hit > ... go to 4, not 5

opt.number = true -- display relative line numbers
opt.relativenumber = true -- show line numbers

opt.shortmess = "aOstTc" -- shortens messages to aviod 'press a key' prompt
opt.ruler = true -- always show current positions along the bottom
opt.showcmd = true -- show the command being typed
opt.signcolumn = "yes" -- Use a gutter for git-gutter and LSP messages

opt.spell = true
opt.spelllang = { "en_us" }

