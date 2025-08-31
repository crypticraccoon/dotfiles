local vim = vim
return {
	{
		"nvim-lua/plenary.nvim"
	},
	{
		"tpope/vim-surround"
	},
	{
		"folke/todo-comments.nvim",
		opts = function()
			require "todo-comments".setup()
		end
	},
	{
		'preservim/nerdcommenter',
	},
	{
		'jiangmiao/auto-pairs'
	},
	{
		"akinsho/toggleterm.nvim",
		event = "BufWinEnter",
		opts = { open_mapping = [[<c-\>]]
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		opts = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


			local telescopeConfig = require("telescope.config")

			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			table.insert(vimgrep_arguments, "--hidden")
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			table.insert(vimgrep_arguments, "!**/node_modules/*")

			require('telescope').setup {
				extensions = {
					fzf = {
						fuzzy = true,       -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					}
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
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/node_modules/*" },
						theme = "dropdown",
					}
				},

			}
		end
	},
	{
		'LukasPietzschmann/telescope-tabs',
		config = function()
			require('telescope').load_extension 'telescope-tabs'
			require('telescope-tabs').setup {
				vim.keymap.set('n', '<leader>ft', ":Telescope telescope-tabs list_tabs<CR>", {})
			}
		end,
	},
	{
		"tiagovla/scope.nvim",
		config = function()
			require "scope".setup()
		end
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		opts = {
			{
				options = {
					mode = "tabs"
				}
			}
		},
		config = function()
			vim.keymap.set("n", "<Tab>", ":bnext<CR>")
			vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
			require("bufferline").setup({})
		end
	},
	{
		'easymotion/vim-easymotion',
		config = function()
			--require("vim-easymotion").setup({})
			--let g:EasyMotion_do_mapping = 0 " Disable default mappings

			--" Jump to anywhere you want with minimal keystrokes, with just one key binding.
			--" `s{char}{label}`
			--nmap s <Plug>(easymotion-overwin-f)
			--" or
			--" `s{char}{char}{label}`
			--" Need one more keystroke, but on average, it may be more comfortable.
			--nmap s <Plug>(easymotion-overwin-f2)

			--" Turn on case-insensitive feature
			--let g:EasyMotion_smartcase = 1

			--" JK motions: Line motions
			--map <Leader>j <Plug>(easymotion-j)
			--map <Leader>k <Plug>(easymotion-k)
		end

	},
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod',                     lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = function()
			return {
				signs                        = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signs_staged                 = {
					add          = { text = '┃' },
					change       = { text = '┃' },
					delete       = { text = '_' },
					topdelete    = { text = '‾' },
					changedelete = { text = '~' },
					untracked    = { text = '┆' },
				},
				signs_staged_enable          = true,
				signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir                 = {
					follow_files = true
				},
				auto_attach                  = true,
				attach_to_untracked          = false,
				current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts      = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
					use_focus = true,
				},
				current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
				sign_priority                = 6,
				update_debounce              = 100,
				status_formatter             = nil, -- Use default
				max_file_length              = 40000, -- Disable if file is longer than this (in lines)
				preview_config               = {
					-- Options passed to nvim_open_win
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1
				},
			}
		end
	}

}
