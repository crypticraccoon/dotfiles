local vim = vim

vim.pack.add({
	'https://github.com/easymotion/vim-easymotion',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/kristijanhusak/vim-dadbod-ui',
	"https://github.com/tpope/vim-surround",
	"https://github.com/folke/todo-comments.nvim",
	'https://github.com/preservim/nerdcommenter',
	"https://github.com/rachartier/tiny-code-action.nvim",
	"https://github.com/m4xshen/autoclose.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

require("todo-comments").setup({})
require("autoclose").setup({})

require('nvim-treesitter').setup()
require('nvim-treesitter').install(TSlang)

vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 2
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.cmd("set nofoldenable")
