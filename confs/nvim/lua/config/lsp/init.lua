local vim = vim
vim.pack.add({
	 "https://github.com/mason-org/mason.nvim",
})


require("mason").setup({
	 vim.keymap.set('n', '<C-m>', ':Mason<CR>', { noremap = true, silent = false });
})

require("config.lsp.completion")
--require("config.lsp.formatter")
require("config.lsp.lsp")
