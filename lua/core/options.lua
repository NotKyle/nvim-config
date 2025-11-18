---@diagnostic disable: undefined-global
vim.env.PHP_CS_FIXER_IGNORE_ENV = "1"

vim.opt.showtabline = 0
vim.opt.laststatus = 0
vim.opt.clipboard = "unnamedplus"
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indentation
-- vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
-- End Indentation

vim.opt.scrolloff = 8
vim.opt.swapfile = false

-- Backup and Undo
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backup//"
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.autoread = true

vim.opt.iskeyword:append({ "-", "@" })
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.history = 10000
vim.opt.background = "dark"
vim.opt.list = true
vim.opt.listchars = {
	tab = "› ",
	trail = "·",
	extends = "⟩",
	precedes = "⟨",
}
-- space = "·",

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	-- virtual_lines = { only_current_line = true },
})
vim.opt.iskeyword:append({ "-", "@" })

vim.cmd([[filetype plugin indent on]])

vim.cmd([[ set foldmethod=manual ]])

vim.cmd([[ set nohidden ]])

vim.o.foldcolumn = "1" -- '0' is not bad
-- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- vim.o.foldmevelstart = 99
vim.o.foldenable = false

vim.opt.sessionoptions =
	{ "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal", "localoptions" }
vim.opt.termguicolors = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish! For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Add your custom plugin directory to runtimepath
local custom_plugin_dir = vim.fn.expand("~/Projects/Neovim")

if vim.fn.isdirectory(custom_plugin_dir) == 1 then
	vim.opt.runtimepath:append(custom_plugin_dir)
end

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.completeopt = "menu,menuone,noinsert,popup,fuzzy"

-- In your Neovim config
-- vim.lsp.handlers["textDocument/hover"] = function() end

vim.o.laststatus = 3

vim.o.winborder = "single"

return {}
