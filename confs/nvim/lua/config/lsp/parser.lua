local vim = vim

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require('nvim-treesitter').setup()
require('nvim-treesitter').install(TSlang)

vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 2
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.cmd("set nofoldenable")
