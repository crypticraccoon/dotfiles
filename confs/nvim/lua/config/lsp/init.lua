local vim = vim

--TODO: Finalize lsp and formatter auto installation and start

vim.pack.add({
	 "https://github.com/noirbizarre/ensure.nvim",
	"https://github.com/mason-org/mason.nvim",
})

require("mason").setup({
	vim.keymap.set('n', '<C-m>', ':Mason<CR>', { noremap = true, silent = false }),
})

require("config.lsp.completion")
require("config.lsp.lsp")
require("config.lsp.formatter")
require("config.lsp.parser")

-- NOTE: run :Ensure to install
require("ensure").setup({
	lsp = {
		enable = Lsps,
	},
	formatters = Formatters,
	parsers = TSlang,

	--packages = { 
		--"codespell"
	--},
})
