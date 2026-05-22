local vim = vim;

--https://github.com/neovim/nvim-lspconfig/tree/master/lsp

local packages = {
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"pyright",
	--"autopep8",
	--"jsonlint",
	--"yamllint",
	--"yq",
	--"yaml-language-server",
	--"vtsls",
	--"prettier",
	--"prettierd",
	--"terraform-ls",
	--"markdown_oxide",
	--"markdownlint",
	--"helm-ls",
	--"docker-language-server",
	--"docker-compose-language-server",
	--"gh",
	--"gh-actions-language-server"
}

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim"
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>s', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

vim.lsp.enable("lua_ls", {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = 'Disable' },
		},
	},
})

vim.lsp.enable('dartls', {
	cmd = { 'dart', 'language-server', '--protocol=lsp' },
	filetypes = { 'dart' },
	root_markers = { 'pubspec.yaml' },
	init_options = {
		onlyAnalyzeProjectsWithOpenFiles = true,
		suggestFromUnimportedLibraries = true,
		closingLabels = true,
		outline = true,
		flutterOutline = true,
	},
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
	ensure_installed = packages,
})

--vim.lsp.enable("gopls")
--vim.lsp.enable("pyright")
--vim.lsp.enable("autopep8")
--vim.lsp.enable("rust_analyzer")
--vim.lsp.enable("gopls")
--vim.lsp.enable("pyright")
--vim.lsp.enable("jsonlint")
--vim.lsp.enable("yamllint")
--vim.lsp.enable("yq")
--vim.lsp.enable("yaml-language-server")
--vim.lsp.enable("vtsls")
--vim.lsp.enable("prettier")
--vim.lsp.enable("prettierd")
--vim.lsp.enable("terraform-ls")
--vim.lsp.enable("markdown_oxide")
--vim.lsp.enable("markdownlint")
--vim.lsp.enable("helm-ls")
--vim.lsp.enable("docker-language-server")
--vim.lsp.enable("docker-compose-language-server")
--vim.lsp.enable("gh")
--vim.lsp.enable("gh-actions-language-server")
