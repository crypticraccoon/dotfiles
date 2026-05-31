local vim = vim;

vim.pack.add({
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/tiagovla/scope.nvim",
})

require("scope").setup({
})

require('bufferline').setup({
	options = {
		always_show_bufferline = true,
		mode = "buffer",
		show_tab_indicators = true,
		show_duplicate_prefix = false,
		separator_style = "thin",
		enforce_regular_tabs = true,
	}
})


vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
