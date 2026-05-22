local vim = vim

vim.pack.add({
	'https://github.com/easymotion/vim-easymotion',
	'https://github.com/lewis6991/gitsigns.nvim',
	'https://github.com/kristijanhusak/vim-dadbod-ui',
	"https://github.com/tpope/vim-surround",
	"https://github.com/folke/todo-comments.nvim",
	'https://github.com/preservim/nerdcommenter',
	"https://github.com/rachartier/tiny-code-action.nvim",

	--"https://github.com/akinsho/toggleterm.nvim",
	--"https://github.com/nvim-neo-tree/neo-tree.nvim",
	--"https://github.com/MunifTanjim/nui.nvim",
	--"https://github.com/antosha417/nvim-lsp-file-operations",
	--'https://github.com/jiangmiao/auto-pairs'

	--"https://github.com/nvim-treesitter/nvim-treesitter",
})

--vim.keymap.set("n", "<C-n>", ":Neotree<CR>")

require("todo-comments").setup({})

--require("toggleterm").setup({
--open_mapping = [[<c-\>]]
--})
