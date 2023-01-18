local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

wk.setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		-- Use which-key for spelling hints
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<Cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
})

-- KEY MAPPINGS
local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

-- NOTE: Prefer using : over <Cmd> as the latter avoids going back in normal-mode.
-- See https://neovim.io/doc/user/map.html#:map-Cmd
local vmappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggles line comment in VISUAL mode" },
}

local mappings = {
	["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggles line comment on the current line" },
	["c"] = { "<Cmd>BufferClose!<CR>", "Close buffer" },
	["d"] = { "<C-w>q", "Delete current window" },
	["h"] = { '<Cmd>let @/=""<CR>', "No Highlight" },
	["q"] = { "<Cmd>q<CR>", "Quit Vim" },
	["Q"] = { "<Cmd>q!<CR>", "Quit Vim without save" },
	b = {
		name = "Buffers",
		d = { "<Cmd>BufferClose!<CR>", "Close buffer" },
		D = { "<Cmd>BufferOrderByDirectory<CR>", "Sort buffers by directory" },
		f = { "<Cmd>Telescope buffers<CR>", "Find buffer" },
		j = { "<Cmd>BufferPick<CR>", "Jump to buffer" },
		h = { "<Cmd>BufferCloseBuffersLeft<CR>", "Close all buffers to the left" },
		l = { "<Cmd>BufferCloseBuffersRight<CR>", "Close all buffers to the right" },
		L = { "<Cmd>BufferOrderByLanguage<CR>", "Sort buffer by language" },
		q = { "<Cmd>BufferCloseAllButCurrent<CR>", "Close all but current buffer" },
		w = { "<Cmd>BufferWipeout<CR>", "Wipeout buffer" },
	},
	f = {
		name = "File",
		e = { "<Cmd>Telescope file_browser<CR>", "File Explorer" },
		f = { "<Cmd>Telescope find_files<CR>", "Find file" },
		g = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
		h = { "<Cmd>Telescope help_tags<CR>", "Help tags" },
		s = { "<Cmd>w!<CR>", "Save file" },
		S = { "<Cmd>wq<CR>", "Save file and quit" },
	},
	g = {
		name = "Git",
		j = { "<Cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
		k = { "<Cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
		l = { "<Cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
		p = { "<Cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
		r = { "<Cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
		R = { "<Cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
		s = { "<Cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
		u = { "<Cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },
	},
	l = {
		name = "LSP",
		i = { "<Cmd>LspInfo<CR>", "Implementation" },
		I = { "<Cmd>LspInstallInfo<CR>", "Info" },
		q = { "<Cmd>lua vim.diagnostic.setloclist<CR>", "Quickfix" },
		Q = { "<Cmd>Telescope quickfix<CR>", "Quickfix" },
		s = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
		S = { "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
		w = { "<Cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
		W = { "<Cmd>Telescope lsp_document_diagnostics<CR>", "Document Diagnostics" },
	},
	s = {
		name = "Search",
		b = { "<Cmd>Telescope git_branches<CR>", "Checkout branch" },
		c = { "<Cmd>Telescope colorscheme<CR>", "Colorscheme" },
		C = { "<Cmd>Telescope commands<CR>", "Commands" },
		f = { "<Cmd>Telescope find_files<CR>", "Find File" },
		h = { "<Cmd>Telescope help_tags<CR>", "Find Help" },
		k = { "<Cmd>Telescope keymaps<CR>", "Keymaps" },
		M = { "<Cmd>Telescope man_pages<CR>", "Man Pages" },
		r = { "<Cmd>Telescope oldfiles<CR>", "Open Recent File" },
		R = { "<Cmd>Telescope registers<CR>", "Registers" },
		t = { "<Cmd>Telescope live_grep<CR>", "Text" },
	},
	w = {
		name = "Window",
		h = { "<C-w>h", "Go to the left window" },
		j = { "<C-w>j", "Go to the down window" },
		k = { "<C-w>k", "Go to the up window" },
		l = { "<C-w>l", "Go to the right window" },
		d = { "<C-w>q", "Delete current window" },
		s = { "<Cmd>split<CR>", "Split window" },
		t = { "<C-w>T", "Break out into a new tab" },
		v = { "<Cmd>vsplit<CR>", "Split window vertically" },
		w = { "<C-w>w", "Switch windows" },
		x = { "<C-w>x", "Swap current with next" },
	},
}

wk.register(mappings, opts)
wk.register(vmappings, vopts)
