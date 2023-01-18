local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

ts.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	rainbow = {
		enable = true,
		extended_mode = false,
		max_file_lines = 1000,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false, -- disable the CursorHold autocommand
		config = {
			-- Languages that have a single comment style
			typescript = "// %s",
			css = "/* %s */",
			scss = "/* %s */",
			html = "<!-- %s -->",
			svelte = "<!-- %s -->",
			vue = "<!-- %s -->",
			json = "",
			lua = "-- %s",
		},
	},
	ensure_installed = {
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
		"go",
		"lua",
		"fish",
		"json",
		"yaml",
		"toml",
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
