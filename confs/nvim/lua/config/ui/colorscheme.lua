local vim = vim;

vim.pack.add({
	'https://github.com/rebelot/kanagawa.nvim',
	'https://github.com/wnkz/monoglow.nvim',
	"https://github.com/rose-pine/neovim",
	"https://github.com/ntk148v/komau.vim",
	'https://github.com/n1ghtmare/noirblaze-vim',
	"https://github.com/nikolvs/vim-sunbather",
	"https://github.com/dotsilas/darcubox-nvim",
	"https://github.com/sainnhe/gruvbox-material",
	"https://github.com/AlexvZyl/nordic.nvim",
	'https://github.com/sainnhe/everforest',
	"https://github.com/sainnhe/sonokai",
	'https://github.com/ribru17/bamboo.nvim',
	"https://github.com/dasupradyumna/midnight.nvim",
	"https://github.com/nyoom-engineering/oxocarbon.nvim"

})


require("nordic").setup({
	transparent = {
		bg = false,
		float = false,
	},
	bright_border = false,
	swap_backgrounds = true,
	on_highlight = function(highlights, _palette)
		highlights.Visual = { bg = _palette.white0, fg = _palette.black0
		}
	end,
})

vim.cmd([[ let g:gruvbox_material_foreground = "material"]])
vim.cmd([[ let g:gruvbox_material_background = 'hard' ]])
vim.cmd([[ let g:gruvbox_material_disable_italic_comment = 1 ]])
vim.cmd([[ let g:gruvbox_material_enable_bold = 1 ]])
vim.cmd([[ let g:gruvbox_material_ui_contrast = "high"]])
vim.cmd([[ let g:gruvbox_material_better_performance = 1]])
vim.cmd([[ let g:gruvbox_material_visual = 'red background']])

vim.cmd([[ let g:sonokai_style = 'andromeda']])
vim.cmd([[ let g:sonokai_better_performance = 1 ]])

vim.cmd.colorscheme('gruvbox-material')


--vim.g.everforest_enable_italic = true
--vim.g.everforest_background = "hard"
--vim.g.everforest_better_performance = 1
