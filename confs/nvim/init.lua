local vim = vim
local set = vim.opt
local cmd = vim.cmd
local map = vim.keymap.set
local opt = vim.opt
local api = vim.api

vim.loader.enable()
vim.defer_fn(function() pcall(require, "impatient") end, 0)
---------------------------------DEFAULT OPTIONS

set.shiftwidth = 3
set.conceallevel = 0
set.hidden = true
set.autoindent = true
set.ruler = false
set.mouse = "a"
set.swapfile = false
opt.termguicolors = true
set.number = true
set.relativenumber = true
set.numberwidth = 3
set.shadafile = "NONE"
set.tabstop = 2
set.shadafile = ""
vim.o.pumheight = 10 -- Max items to show in pop up menu
vim.o.cmdheight = 1  -- Max items to show in command menu
cmd('set lazyredraw')


--Folding
set.foldnestmax = 2
vim.opt.foldmethod = "expr"
cmd("set nofoldenable")
----------------------------------------
---------------------------------KEYMAPS
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
map('n', '<A-left>', '<C-w>h', { noremap = true, silent = false })
map('n', '<A-right>', '<C-w>l', { noremap = true, silent = false })
map('n', '<A-down>', '<C-w>j', { noremap = true, silent = false })
map('n', '<A-up>', '<C-w>k', { noremap = true, silent = false })
map('n', '<leader>s', ':source ~/personal/confs/nvim/init.lua<CR>',
	{ noremap = true })
map('n', '<C-Left>', ':tabprevious<CR>', { noremap = true })
map('n', '<C-Right>', ':tabnext<CR>', { noremap = true })
map('v', '<C-c>', '"+y', { noremap = true })

map('n', '<C-d>', '<C-d>zz', { noremap = true })
map('n', '<C-u>', '<C-u>zz', { noremap = true })
map("i", "<C-c>", "<Esc>", { noremap = false })

map("n", "<C-z>", ":q!<CR>", { noremap = true })
map('n', '<C-c>', ':w!<CR>', { noremap = true })

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

require("config.lazy")

set.showtabline = 2

vim.cmd.colorscheme('gruvbox-material')
--vim.cmd.colorscheme('bamboo')
api.nvim_set_hl(0, "Folded", { bg="none", fg="#e75a7c"})

set.syntax = "on"

