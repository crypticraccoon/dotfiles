vim.pack.add({
	 "https://github.com/neovim/nvim-lspconfig",
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

vim.lsp.enable("lua_ls")

vim.lsp.enable('dartls', {
	 cmd = { "dart", "language-server", "--protocol=lsp" },
	 filetypes = { "dart" },
	 init_options = {
		closingLabels = true,
		flutterOutline = true,
		onlyAnalyzeProjectsWithOpenFiles = true,
		outline = true,
		suggestFromUnimportedLibraries = true,
	 },
	 settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
	 },
})
