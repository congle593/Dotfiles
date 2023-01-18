local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
	return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if not status_luasnip then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-h>"] = cmp.mapping.abort(),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif cmp.visible() then
				fallback()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = kind_icons[vim_item.kind]
			vim_item.menu = ({
				luasnip = "[Snippet]",
				nvim_lsp = "[LSP]",
				nvim_lsp_signature_help = "[Param]",
				path = "[Path]",
				buffer = "[Buffer]",
				emmet_vim = "[Emmet]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{
			name = "nvim_lsp",
			keyword_length = 1,
			max_item_count = 30,
			priority = 10,
			entry_filter = function(entry, ctx)
				return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
			end,
		},
		{
			name = "luasnip",
			keyword_length = 1,
			priority = 9,
			entry_filter = function(entry, ctx)
				local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
				if kind == "Snippet" and ctx.prev_context.filetype == "html" then
					return false
				end
				if kind == "Text" then
					return false
				end
				return true
			end,
		},
		{ name = "emmet_vim", keyword_length = 1, priority = 8 },
		{ name = "nvim_lsp_signature_help", keyword_length = 2, priority = 7 },
		{ name = "path", keyword_length = 2, priority = 6 },
		{ name = "buffer", keyword_length = 3, priority = 5 },
		{ name = "nvim_lua", keyword_length = 3, priority = 4 },
		-- { name = "cmp_tabnine" },
		-- { name = "calc" },
		-- { name = "emoji" },
		-- { name = "treesitter" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	enabled = function()
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		local context = require("cmp.config.context")
		-- Disable completion in Telescope buffer
		if buftype == "prompt" then
			return false
		end
		-- Disable completion in comments
		-- Keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
})
