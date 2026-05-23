return {
	{
		treesitter = { "lua" },
		mason = { "stylua", "lua-language-server" },
		lsp = { "lua_ls" },
	},
	{
		treesitter = { "go" },
		mason = { "gopls" },
		lsp = { "gopls" },
	},
	{
		treesitter = { "json" },
		mason = { "jq", "jsonlint" },
	},
	{
		treesitter = { "yaml" },
		mason = { "yq", "yamllint", "yaml-language-server", "actionlint" },
		lsp = { "yamlls" },
	},
	{
		treesitter = { "javascript", "typescript", "tsx", "html", "css" },
		mason = { "vtsls", "eslint_d", "prettier", "prettierd" },
		lsp = { "vtsls" },
	},
	{
		treesitter = { "bash" },
		mason = { "bash-language-server" },
		lsp = { "bashls" },
	},
	{
		treesitter = { "rust" },
		mason = { "rust-analyzer" },
		lsp = { "rust_analyzer" },
	},
	{
		mason = { "markdownlint", "markdown-oxide" },
		lsp = { "markdown_oxide" },
	},
	{
		mason = { "docker-language-server" },
		lsp = { "docker_language_server" },
	},
	{
		mason = { "docker-compose-language-server" },
		lsp = { "docker_language_server" },
	},
}
