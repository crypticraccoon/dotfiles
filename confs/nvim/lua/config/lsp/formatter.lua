--local vim = vim
vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

local _ = {
	"autopep8",
	"jsonlint",
	"yamllint",
	"yq",
	"prettier",
	"prettierd",
	"markdown_oxide",
	"markdownlint",
	"gh",
}

require("conform").setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		yaml = { "yq", lsp_format = "fallback" },
		rust = { "rustfmt", lsp_formaaat = "fallback" },
		lua = { "stylua" },
		json = { "jq" },
		go = { "gofmt" },
		python = { "autopep8" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "eslint_d", "prettier" },
		typescriptreact = { "eslint_d", "prettier" },
	},
})

--vim.keymap.set("n", "<leader>f", function()
--require("conform").format({ formatters = { "yq" } })
--end, { desc = "Toggle auto format" })
