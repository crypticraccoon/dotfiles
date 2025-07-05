local vim = vim

return {
	{
		'kyazdani42/nvim-web-devicons'
	},
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "┊",
			},
			scope = { enabled = false },

		},
	},
	{
		"preservim/nerdtree",
		config = function()
			vim.keymap.set("n", "<C-n>", ":NERDTreeToggle<CR>")
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate",
		opts = function()
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { "c", "lua", "rust", "bash", "json", "json5", "javascript", "html", "css", "go", "dart" },
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true }
			}
		end
	},
	{
		'norcalli/nvim-colorizer.lua',
		config =
			 function()
				 require("colorizer").setup({
					 css = {
						 RGB       = true,
						 hsl_fn    = true,
						 css       = true,
						 css_fn    = true,
						 mode      = "background", -- Set the display mode.
						 lowercase = true, -- Enable lowercase color names
					 }
				 })
			 end
	},
	{
		"nyoom-engineering/oxocarbon.nvim"
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = function()
			require "lualine".setup {
				options = {
					--theme = 'sonokai',
					--theme = 'oxocarbon',
					theme = 'gruvbox-material',
					section_separators = '',
					component_separators = ''

				}
			}
		end,
	},

	{
		'rcarriga/nvim-notify',
		config = function(_, opts)
			local x = require("notify").setup({
				background_colour = "#000000",
				fps = 60,
				top_down = false,
				render = "compact",
			})
			vim.notify = require("notify")
		end,
	},

	{
		'sainnhe/gruvbox-material',
		config = function()
			vim.cmd([[ let g:gruvbox_material_foreground = "original"]])
			vim.cmd([[ let g:gruvbox_material_background = 'hard' ]])
			vim.cmd([[ let g:gruvbox_material_disable_italic_comment = 0 ]])
			vim.cmd([[ let g:gruvbox_material_enable_italic = 0 ]])
			vim.cmd([[ let g:gruvbox_material_enable_bold = 1 ]])
			vim.cmd([[ let g:gruvbox_material_ui_contrast = "high"]])
			vim.cmd([[ let g:gruvbox_material_better_performance = 1]])
			vim.cmd([[ let g:gruvbox_material_visual = 'red background']])

			vim.opt.background = "dark"
		end
	},
	{
		'ribru17/bamboo.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('bamboo').setup {
				-- optional configuration here
			}
			vim.opt.background = "dark"
		end,
	},
	{
		"sainnhe/sonokai",
	},
	{
		'sainnhe/everforest',
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = "hard"
			vim.g.everforest_better_performance = 1
			vim.opt.background = "dark"
			vim.g.airline_theme = 'everforest'
			--require 'lualine'.setup { options = {
			--theme = 'everforest' }
			--}
		end
	},

	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({
				-- table: default groups
				groups = {
					'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
					'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
					'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
					'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
					'EndOfBuffer',
				},
				-- table: additional groups that should be cleared
				extra_groups = {},
				-- table: groups you don't want to clear
				exclude_groups = {},
				-- function: code to be executed after highlight groups are cleared
				-- Also the user event "TransparentClear" will be triggered
				on_clear = function() end,
			})
		end
	},
	{
		"AlexvZyl/nordic.nvim",
		config = function()
			require("nordic").setup({
				transparent = {
					-- Enable transparent background.
					bg = false,
					-- Enable transparent background for floating windows.
					float = false,
				},
				bright_border = false,
				swap_backgrounds = true,
			})
		end
	}
	--{
	--"folke/twilight.nvim",
	----opts = {
	------expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
	------"fn",
	------"func",
	------"function",
	------"method",
	------"table",
	------"if_statement",
	------},
	------ your configuration comes here
	------ or leave it empty to use the default settings
	------ refer to the configuration section below
	----},
	--config = function()
	--require("twilight").setup({
	--expand = {
	----"fn",
	----"func",
	--"function",
	--"method",
	--"table",
	--"if_statement",
	--},
	--})
	--vim.cmd([[ Twilight ]])
	--end
	--}
}
