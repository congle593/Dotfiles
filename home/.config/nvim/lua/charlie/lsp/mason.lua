local status_mason, mason = pcall(require, "mason")
if not status_mason then
	return
end

local status_lsp, lsp = pcall(require, "mason-lspconfig")
if not status_lsp then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- Auto install LSP servers with mason.
lsp.setup({
	ensure_installed = {
		"html",
		"tailwindcss",
		"tsserver",
		"gopls",
		"jsonls",
		"sumneko_lua",
	},
})
