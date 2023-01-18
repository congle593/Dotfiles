local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.setup({
	-- Icons
	-- diagnostic_header = { "😡", "😥", "😤", "😐" },
})

-- Keymaps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Jump Diagnostic and Show Diagnostics
keymap("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "gj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "gk", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

-- Peek Definition
keymap("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", opts)

-- Hover Doc
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)

-- Rename
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

-- Code Action
keymap("n", "ga", "<Cmd>Lspsaga code_action<CR>", opts)
keymap("v", "ga", "<Cmd><C-U>Lspsaga range_code_action<CR>", opts)

-- Async Lsp Finder
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)

-- Float terminal
keymap("n", "<A-t>", "<Cmd>Lspsaga term_toggle<CR>", opts)
keymap("t", "<A-t>", "<Cmd>Lspsaga term_toggle<CR>", opts)
