local vim = vim
vim.pack.add({
	"https://github.com/nvim-telescope/nvim-lua/plenary.nvim",
})

require("config.functionality.base")
require("config.functionality.tabs")
require("config.functionality.misc")
