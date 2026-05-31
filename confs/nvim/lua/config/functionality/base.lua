local vim = vim
vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	animate = {
		enabled = true,
		duration = 20,
		easing = "linear",
		fps = 120,
	},
})

-- Misc
vim.keymap.set('n', "<leader>ts", function() Snacks.scratch() end, { noremap = true, silent = false })
vim.keymap.set('n', "<c-\\>", function() Snacks.terminal() end, { noremap = true, silent = false })

-- Lsp
vim.keymap.set('n', "<leader>ls", function() Snacks.picker.lsp_symbols() end, { noremap = true, silent = false })
vim.keymap.set('n', "<leader>ld", function() Snacks.picker.lsp_definitions() end, { noremap = true, silent = false })
vim.keymap.set('n', "<leader>lD", function() Snacks.picker.lsp_declarations() end, { noremap = true, silent = false })

-- Explorer
vim.keymap.set('n', "<C-n>", function() Snacks.explorer() end, { noremap = true, silent = false })

-- Files, words etc
vim.keymap.set('n', "<Space>fs", function() Snacks.picker.smart() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>ff", function() Snacks.picker.files() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>fb", function() Snacks.picker.buffers() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>fn", function() Snacks.picker.notifications() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>fg", function() Snacks.picker.grep() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>fG", function() Snacks.picker.grep_buffers() end, { noremap = true, silent = false })
vim.keymap.set('v', "<Space>fg", function() Snacks.picker.grep_word() end, { noremap = true, silent = false })
vim.keymap.set('n', "<Space>fA", function() Snacks.picker.colorschemes() end, { noremap = true, silent = false })

--
--vim.keymap.set('n', "]]", function() Snacks.words.jump(vim.v.count1) end, { noremap = true, silent = false })
--vim.keymap.set('n', "[[", function() Snacks.words.jump(-vim.v.count1) end, { noremap = true, silent = false })
