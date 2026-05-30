local vim = vim;

--https://github.com/neovim/nvim-lspconfig/tree/master/lsp

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	--"https://github.com/mason-org/mason-lspconfig.nvim"
})

--require("mason-lspconfig").setup({
--ensure_installed = lsps,
--automatic_enable = {
--"lua_ls",
--"vimls"
--}
--})

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
	end,
})

vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				 path ~= vim.fn.stdpath('config')
				 and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.api.nvim_get_runtime_file("lua/lspconfig", false)[1],
				},
			},
		})
	end,
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = 'Disabled' },

		},
	},
})

vim.lsp.config('dartls', {
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

vim.lsp.config("yamlls", {
	cmd = function(dispatchers, config)
		local cmd = 'yaml-language-server'
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
	end,
	filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
	settings = {
		redhat = { telemetry = { enabled = false } },
		yaml = { format = { enable = true } },
	},
	on_init = function(client)
		client.server_capabilities.documentFormattingProvider = true
	end,
})

vim.lsp.config("gh_actions_ls", {
	cmd = { 'gh-actions-language-server', '--stdio' },
	filetypes = { 'yaml' },

	-- `root_dir` ensures that the LSP does not attach to all yaml files
	root_dir = function(bufnr, on_dir)
		local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
		if
			 vim.endswith(parent, '/.github/workflows')
			 or vim.endswith(parent, '/.forgejo/workflows')
			 or vim.endswith(parent, '/.gitea/workflows')
		then
			on_dir(parent)
		end
	end,
	handlers = {
		['actions/readFile'] = function(_, result)
			if type(result.path) ~= 'string' then
				return nil, nil
			end
			local file_path = vim.uri_to_fname(result.path)
			if vim.fn.filereadable(file_path) == 1 then
				local f = assert(io.open(file_path, 'r'))
				local text = f:read('*a')
				f:close()

				return text, nil
			end
			return nil, nil
		end,
	},
	init_options = {},
	capabilities = {
		workspace = {
			didChangeWorkspaceFolders = {
				dynamicRegistration = true,
			},
		},
	},
})

vim.lsp.config("lemminx", {
	cmd = { 'lemminx' },
	filetypes = { 'xml', 'svg' },
})

vim.lsp.enable("lemminx")
vim.lsp.enable("lua_ls")
vim.lsp.enable('dartls')
vim.lsp.enable("bashls")
vim.lsp.enable("yamlls")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("gopls")
vim.lsp.enable("vtsls")
vim.lsp.enable("terraform-ls")
vim.lsp.enable("helm-ls")
vim.lsp.enable("docker-language-server")
vim.lsp.enable("docker-compose-language-server")
vim.lsp.enable("gh-actions-language-server")
