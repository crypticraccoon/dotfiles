vim.pack.add({
	'https://github.com/kyazdani42/nvim-web-devicons',
	"https://github.com/catgoose/nvim-colorizer.lua",
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://github.com/rcarriga/nvim-notify',
	"https://github.com/xiyaowong/transparent.nvim",
	"https://github.com/rachartier/tiny-code-action.nvim",
})

vim.keymap.set(
	{ "n", "v" },
	"<space>s",
	function()
		require("tiny-code-action").code_action()
	end,
	{ noremap = true, silent = true }
)


local colors = {
	blue = "#83a598",
	green = "#8ec07c",
	violet = "#d3869b",
	yellow = "#d8a657",
	red = "#FF4A4A",
	cream = "#fff4d2",
	black = "#1d1d1d",
	grey = "#393939",
	dark = "#292929",
}


require("colorizer").setup({
	user_default_options = {
		RGB = true,
		RGBA = true,
		RRGGBB = true,
		RRGGBBAA = true,
		AARRGGBB = true,
	}
})

require("lualine").setup({
	options = {
		globalstatus = true,
		theme = 'gruvbox-material',
		section_separators = '',
		component_separators = ''

	},
	sections = {
		lualine_a = {
			"mode",
			--"tabs",
		},
		lualine_b = {
			"branch",
			"diff",
			"diagnostics",
		},
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 3,
				shorting_target = 0,
			},
		},

		lualine_x = {

			"vim.lsp.get_clients()[1].name",
			"filesize",
			--"branch",
			--"diff",
			--"diagnostics",
		},
		lualine_y = {
			"searchcount",
			"selectioncount",
			"encoding",
			"filetype",
		},
		lualine_z = {
			"progress",
			"location",
		},
	},
})


require("notify").setup({
	background_colour = "#000000",
	fps = 60,
	top_down = false,
	render = "compact",
})
