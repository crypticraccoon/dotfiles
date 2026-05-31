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
})

require("todo-comments").setup({})
require("autoclose").setup({})
