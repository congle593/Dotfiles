local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting

local diagnostics = null_ls.builtins.diagnostics

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

null_ls.setup({
	debug = false,
	sources = {
		-- Prettier - ESLint
		formatting.prettierd,
		diagnostics.eslint_d,

		-- Golang
		formatting.goimports,
		formatting.gofumpt,
		diagnostics.golangci_lint,
		diagnostics.revive,

		-- Fish shell
		formatting.fish_indent,
		diagnostics.fish,

		-- Lua
		formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
})
