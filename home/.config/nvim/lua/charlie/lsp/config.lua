local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
	return
end

local servers = {
	"html",
	"tailwindcss",
	"tsserver",
	"gopls",
	"jsonls",
	"sumneko_lua",
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "<A-n>", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<A-p>", vim.diagnostic.goto_prev, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)
	-- vim.keymap.set("n", "gr", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gF", vim.lsp.buf.formatting, bufopts)

	-- Avoiding LSP formatting conflicts (use null-ls)
	client.server_capabilities.documentFormattingProvider = false
end

-- Capabilities
local status_cmp, cmp = pcall(require, "cmp_nvim_lsp")
if not status_cmp then
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = cmp.default_capabilities(capabilities)

-- LSP config
for _, server in pairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "charlie.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

-- UI Customization
-- Change diagnostic symbols in the sign column (gutter)
local signs = {
	Error = "",
	Warn = "",
	Info = "",
	Hint = "",
}
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Customizing how diagnostics are displayed
vim.diagnostic.config({
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	virtual_text = {
		prefix = "●",
	},
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})
