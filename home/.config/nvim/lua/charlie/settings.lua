-- VIM OPTIONS
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr" -- folding, set to "expr" for treesitter based foloding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.smarttab = true
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.softtabstop = 2
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.autoindent = true
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.laststatus = 3
vim.opt.fillchars.eob = " "
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
-- vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.breakindent = true
-- vim.opt.colorcolumn = "999999" -- fixes indentline for now
-- vim.opt.inccommand = "split"
-- vim.opt.lazyredraw = true
-- vim.opt.shiftround = true
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
-- vim.opt.spell = false
-- vim.opt.spelllang = "en"
-- vim.opt.shell = "/usr/bin/bash"

-- VIM COMMANDS
-- Highlight on yank
vim.cmd("au TextYankPost * silent! lua vim.highlight.on_yank()")

-- File types
-- Golang
vim.api.nvim_command([[autocmd FileType go setlocal shiftwidth=4 tabstop=4]])
vim.api.nvim_command([[autocmd FileType go setl indentkeys-=<:>]])

-- YAML
vim.api.nvim_command([[autocmd FileType yaml setl indentkeys-=<:>]])
vim.api.nvim_command([[autocmd FileType yml setl indentkeys-=<:>]])
