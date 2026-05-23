local vim = vim

--TODO: Finalize lsp and formatter auto installation and start

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	--"https://github.com/noirbizarre/ensure.nvim"
})

require("mason").setup({
	vim.keymap.set('n', '<C-m>', ':Mason<CR>', { noremap = true, silent = false }),
})

require("config.lsp.completion")
require("config.lsp.lsp")
require("config.lsp.formatter")

--require("ensure").setup({
--lsp = {
--enable = {

----"lua_ls",
----"rust_analyzer",
----"gopls",
----"pyright",
----"yaml-language-server",
----"vtsls",
----"terraform-ls",
----"helm-ls",
----"docker-language-server",
----"docker-compose-language-server",
--"gh_actions_ls",
--},
--},

--formatters = {
--lua = "stylua",
--python = { "ruff_format", "ruff_organize_imports" },
--javascript = "prettier",
--},

--plugins = {
--"ensure.plugin.mason",
--"ensure.plugin.lsp",
--"ensure.plugin.conform",
--},
--})
