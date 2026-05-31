TSlang = {
	"bash",
	"vim",
	"javascript",
	"typescript",
	"dart",
	"rust",
	"python",
	"ninja",
	"nginx",
	"qmljs",
	"regex",
	"meson",
	"kitty",
	"json5",
	"jsdoc",
	"cmake",
	"caddy",
	"yaml",
	"toml",
	"tmux",
	"make",
	"llvm",
	"luap",
	"luau",
	"json",
	"html",
	"helm",
	"diff",
	"xml",
	"tsx",
	"sql",
	"nix",
	"lua",
	"jsx",
	"css",
	"awk",
	"go",
	"c" }

Lsps = {
	"lua_ls",
	"rust_analyzer",
	"gopls",
	"pyright",
	"yaml-language-server",
	"vtsls",
	"terraform-ls",
	"helm-ls",
	"docker-language-server",
	"docker-compose-language-server",
	"gh-actions-language-server",
	"lemminx",
	--"nil",
}

Formatters = {
	python = { "autopep8", lsp_format = "fallback" },
	bash = { "shfmt" },
	yaml = { "yq", lsp_format = "fallback" },
	rust = { "rustfmt", lsp_format = "fallback" },
	lua = { "stylua" },
	json = { "jq" },
	go = { "gofmt" },
	javascript = { "prettierd", "prettier", stop_after_first = true },
	typescript = { "eslint_d", "prettier" },
	typescriptreact = { "eslint_d", "prettier" },
	markdown = { "markdownlint" },
	nix = { "nixfmt" }
}

MasonMisc = {

}

--Formatters = {
--"autopep8",
--"jsonlint",
--"yamllint",
--"yq",
--"prettier",
--"prettierd",
--"markdown_oxide",
--"markdownlint",
--"gh",
--}


--return {
--{
--treesitter = { "lua" },
--mason = { "stylua", "lua-language-server" },
--lsp = { "lua_ls" },
--},
--{
--treesitter = { "go" },
--mason = { "gopls" },
--lsp = { "gopls" },
--},
--{
--treesitter = { "json" },
--mason = { "jq", "jsonlint" },
--},
--{
--treesitter = { "yaml" },
--mason = { "yq", "yamllint", "yaml-language-server", "actionlint" },
--lsp = { "yamlls" },
--},
--{
--treesitter = { "javascript", "typescript", "tsx", "html", "css" },
--mason = { "vtsls", "eslint_d", "prettier", "prettierd" },
--lsp = { "vtsls" },
--},
--{
--treesitter = { "bash" },
--mason = { "bash-language-server" },
--lsp = { "bashls" },
--},
--{
--treesitter = { "rust" },
--mason = { "rust-analyzer" },
--lsp = { "rust_analyzer" },
--},
--{
--mason = { "markdownlint", "markdown-oxide" },
--lsp = { "markdown_oxide" },
--},
--{
--mason = { "docker-language-server" },
--lsp = { "docker_language_server" },
--},
--{
--mason = { "docker-compose-language-server" },
--lsp = { "docker_language_server" },
--},
--}
