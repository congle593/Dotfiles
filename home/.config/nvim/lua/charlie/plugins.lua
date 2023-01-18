local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	--******************************* DEPENDENCIES *******************************--
	-- Packer can manage itself as an optional plugin
	use("wbthomason/packer.nvim")

	-- Icons
	use("kyazdani42/nvim-web-devicons")

	-- Popup
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	--****************************************************************************--

	--****************************** COLOR SCHEMES *******************************--
	use("folke/tokyonight.nvim")
	--****************************************************************************--

	--******************************** WHICH KEY *********************************--
	use("folke/which-key.nvim")
	--****************************************************************************--

	--********************************** VIEW ************************************--
	use("romgrk/barbar.nvim")
	use("hoob3rt/lualine.nvim")
	--****************************************************************************--

	--********************************* SYNTAX ***********************************--
	-- Treesitter & modules
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use("p00f/nvim-ts-rainbow")

	-- Autopairs
	use("windwp/nvim-autopairs")

	-- Comment
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")

	-- Colorizer
	use("norcalli/nvim-colorizer.lua")

	-- Indent Blankline
	use("lukas-reineke/indent-blankline.nvim")

	-- Surround
	use({ "kylechui/nvim-surround", tag = "*" })

	--****************************************************************************--

	--*********************************** LSP ************************************--
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	-- LSP UI
	use("glepnir/lspsaga.nvim")
	use("RRethy/vim-illuminate")
	--****************************************************************************--

	--*********************************** CMP ************************************--
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/nvim-cmp")
	use("rafamadriz/friendly-snippets")

	-- Emmet abbreviation
	use("mattn/emmet-vim")
	use("dcampos/cmp-emmet-vim")

	-- For luasnip users
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	--****************************************************************************--

	--******************************** TELESCOPE *********************************--
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
	})
	use("nvim-telescope/telescope-file-browser.nvim")
	--****************************************************************************--

	--*********************************** GIT ************************************--
	use("lewis6991/gitsigns.nvim")
	--****************************************************************************--

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
