local vim = vim;

vim.pack.add({
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/hrsh7th/nvim-cmp"
})

local function border(hl_name)
	return {
		{ "┌", hl_name },
		{ "─", hl_name },
		{ "┐", hl_name },
		{ "│", hl_name },
		{ "┘", hl_name },
		{ "─", hl_name },
		{ "└", hl_name },
		{ "│", hl_name },
	}
end


local cmp = require('cmp')
cmp.setup({

	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},

	window = {
		completion = {
			border = border("CmpMenuBorder"),
			winhighlight = "Normal:CmpMenu,CursorLine:Question,Search:None",
		},
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
		},
	},

	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),


	sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' }, })

})

cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, }, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})
