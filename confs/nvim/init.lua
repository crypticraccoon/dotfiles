require("vim._core.ui2").enable({})

local vim = vim
local set = vim.opt
local cmd = vim.cmd
local map = vim.keymap.set
local opt = vim.opt
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
set.numberwidth = 1
set.shadafile = "NONE"
set.tabstop = 2
set.shadafile = ""
vim.o.pumheight = 20 -- Max items to show in pop up menu
set.showtabline = 0
set.cmdheight = 0
cmd('set lazyredraw')
--vim.o.autocomplete = true

----------------------------------------
---------------------------------KEYMAPS
vim.keymap.set("n", "]g", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "[g", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
map('n', '<A-left>', '<C-w>h', { noremap = true, silent = false })
map('n', '<A-right>', '<C-w>l', { noremap = true, silent = false })
map('n', '<A-down>', '<C-w>j', { noremap = true, silent = false })
map('n', '<A-up>', '<C-w>k', { noremap = true, silent = false })
map('n', '<leader>s', ':source $HOME/.config/nvim/init.lua<CR>',
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

require("plugin.pack")
