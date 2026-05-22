local vim = vim;

vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	'https://github.com/LukasPietzschmann/telescope-tabs',
})

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,             -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		defaults = {
			layout_config = {
				horizontal = { width = 0.9, height = 0.9 }
				--horiz= { width = 0.9 }
			},

		},
		pickers = {
			find_files = {
				-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
				find_command = { "rg", "--files", "--hidden", "--glob", "!*.md", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" },
				theme = "dropdown",
			}
		},

	}

})

require('telescope-tabs').setup({
	require('telescope').load_extension 'telescope-tabs';
	vim.keymap.set('n', '<leader>ft', ":Telescope telescope-tabs list_tabs<CR>", {})
})



local builtin = require('telescope.builtin')
local telescopeConfig = require("telescope.config")
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

vim.keymap.set('n', '<space>ff', builtin.find_files, {})
vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<space>ft', builtin.treesitter, {})
vim.keymap.set('n', '<space>fe', builtin.diagnostics, {})
vim.keymap.set('n', '<sapce>fh', builtin.help_tags, {})
vim.keymap.set('n', '<space>fb', '<Cmd>Telescope scope buffers<CR>')

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
table.insert(vimgrep_arguments, "!**//*")
table.insert(vimgrep_arguments, "!**/node_modules/*")
