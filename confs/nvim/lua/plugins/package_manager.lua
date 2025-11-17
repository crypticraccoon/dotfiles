return {
	{
		"mason-org/mason.nvim",
		opts = function()
			vim.keymap.set('n', '<C-m>', ':Mason<CR>', { noremap = true, silent = false })

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
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
				filetypes = { "lua" },
			})


			vim.lsp.enable("cssls", {
				filetypes = { "css", "scss" },
			})

			vim.lsp.enable("jsonls", {
				filetypes = { "json", "jsonc" },
			})

			vim.lsp.enable("gopls", {
				cmd = { "gopls" },

				filetypes = { "go" },
			})


			vim.lsp.enable("dockerls", {
				filetypes = { "dockerfile" },
			})


			--vim.lsp.config.bashls.setup({
			--filetypes = { "sh" },
			--})


			----vim.lsp.config.docker_compose_language_service.setup({
			----filetypes = { "yaml" }
			----})
			----vim.lsp.config.sqls.setup({
			----filetypes = { "sql" },
			----on_attach = function(client, _)
			----client.server_capabilities.documentFormattingProvider = false
			----client.server_capabilities.documentRangeFormattingProvider = false
			----end

			----})

			----vim.lsp.config["qmlls"].setup({
			----cmd = { "qmlls6", "-E" },
			----filetypes = { "qml" }
			----})

			----DART LSP, requires dart
			----vim.lsp.config["dartls"].setup({
			----cmd = { "dart", "language-server", "--protocol=lsp" },
			----filetypes = { "dart" },
			----init_options = {
			----closingLabels = true,
			----flutterOutline = true,
			----onlyAnalyzeProjectsWithOpenFiles = true,
			----outline = true,
			----suggestFromUnimportedLibraries = true,
			----},
			------root_dir = root_pattern("pubspec.yaml"),
			----settings = {
			----dart = {
			----completeFunctionCalls = true,
			----showTodos = true,
			----},
			----},
			----on_attach = function(client, bufnr)
			----end,

			----})



			----local capabilities = vim.lsp.protocol.make_client_capabilities()
			----capabilities.textDocument.completion.completionItem.snippetSupport = true

			----local nvim_lsp = require('lspconfig')

			----nvim_lsp.ts_ls.setup {
			----on_attach = on_attach,
			----root_dir = nvim_lsp.util.root_pattern("package.json"),
			----single_file_support = false
			----}
			--end
			--},


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
		end
	},
	--{
	--"williamboman/mason.nvim",
	--opts = function()
	--require("mason").setup()
	----require("mason-lspconfig").setup()
	----require("mason-lspconfig").setup_handlers {
	----function(server_name) -- default handler (optional)
	----vim.lsp.config[server_name].setup {
	----handlers = handlers,
	----on_attach = on_attach,
	----}
	----end,
	----}
	--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


	--vim.keymap.set('n', '<C-m>', ':Mason<CR>', { noremap = true, silent = false })
	---- Use LspAttach autocommand to only map the following keys
	---- after the language server attaches to the current buffer
	--vim.api.nvim_create_autocmd('LspAttach', {
	--group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	--callback = function(ev)
	---- Enable completion triggered by <c-x><c-o>
	--vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

	---- Buffer local mappings.
	---- See `:help vim.lsp.*` for documentation on any of the below functions
	--local opts = { buffer = ev.buf }
	--vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	--vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	--vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	--vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	--vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	--vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
	--vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
	--vim.keymap.set('n', '<space>wl', function()
	--print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	--end, opts)
	--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
	--vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
	--vim.keymap.set({ 'n', 'v' }, '<space>s', vim.lsp.buf.code_action, opts)
	--vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	--vim.keymap.set('n', '<space>f', function()
	--vim.lsp.buf.format { async = true }
	--end, opts)
	--end,
	--})

	----Border Customization
	--local border = {
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--{ "", "FloatBorder" },
	--}

	--local handlers = {
	--["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	--["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	--}

	--local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	--function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	--opts = opts or {}
	--opts.border = opts.border or border
	--return orig_util_open_floating_preview(contents, syntax, opts, ...)
	--end

	--require("lspconfig").dartls.setup()

	----vim.lsp.config.pyright.setup({
	----filetypes = { "py" },
	----})

	----vim.lsp.config.lua_ls.setup({
	----filetypes = { "lua" },
	----})


	----vim.lsp.config.cssls.setup({
	----filetypes = { "css", "scss" },
	----})

	----vim.lsp.config.jsonls.setup({
	----filetypes = { "json", "jsonc" },
	----})

	----vim.lsp.config["gopls"].setup({
	----cmd = { "gopls" },

	----filetypes = { "go" },
	----})


	----vim.lsp.config.dockerls.setup({
	----filetypes = { "dockerfile" },
	----})


	----vim.lsp.config.bashls.setup({
	----filetypes = { "sh" },
	----})


	----vim.lsp.config.docker_compose_language_service.setup({
	----filetypes = { "yaml" }
	----})
	----vim.lsp.config.sqls.setup({
	----filetypes = { "sql" },
	----on_attach = function(client, _)
	----client.server_capabilities.documentFormattingProvider = false
	----client.server_capabilities.documentRangeFormattingProvider = false
	----end

	----})

	----vim.lsp.config["qmlls"].setup({
	----cmd = { "qmlls6", "-E" },
	----filetypes = { "qml" }
	----})

	----DART LSP, requires dart
	----vim.lsp.config["dartls"].setup({
	----cmd = { "dart", "language-server", "--protocol=lsp" },
	----filetypes = { "dart" },
	----init_options = {
	----closingLabels = true,
	----flutterOutline = true,
	----onlyAnalyzeProjectsWithOpenFiles = true,
	----outline = true,
	----suggestFromUnimportedLibraries = true,
	----},
	------root_dir = root_pattern("pubspec.yaml"),
	----settings = {
	----dart = {
	----completeFunctionCalls = true,
	----showTodos = true,
	----},
	----},
	----on_attach = function(client, bufnr)
	----end,

	----})



	----local capabilities = vim.lsp.protocol.make_client_capabilities()
	----capabilities.textDocument.completion.completionItem.snippetSupport = true

	----local nvim_lsp = require('lspconfig')

	----nvim_lsp.ts_ls.setup {
	----on_attach = on_attach,
	----root_dir = nvim_lsp.util.root_pattern("package.json"),
	----single_file_support = false
	----}
	--end
	--},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
		},
		config = function()
			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),

				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' }, }, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
		end
	},
}
