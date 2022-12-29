local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")

local fb_actions = require("telescope").extensions.file_browser.actions

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

telescope.setup({
	defaults = {
		prompt_prefix = " 🔍 ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/*", "node_modules" },
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				width = 0.8,
				prompt_position = "top",
				preview_width = 68,
				preview_cutoff = 120,
			},
		},
		mappings = {
			i = {
				["<C-l>"] = actions.select_default,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["q"] = actions.close,
				["l"] = actions.select_default,
				["<C-l>"] = actions.select_default,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			no_ignore = false,
			hidden = true,
		},
	},
	extensions = {
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			path = "%:p:h",
			cwd = telescope_buffer_dir(),
			hidden = true,
			grouped = true,
			initial_mode = "normal",
			previewer = false,
			layout_config = { width = 60 },
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
					["a"] = fb_actions.create,
					["r"] = fb_actions.rename,
					["m"] = fb_actions.move,
					["c"] = fb_actions.copy,
					["d"] = fb_actions.remove,
					["o"] = fb_actions.open,
					["h"] = fb_actions.goto_parent_dir,
					["*"] = fb_actions.select_all,
				},
			},
		},
	},
})

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
telescope.load_extension("file_browser")
