-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.showtabline = 0
vim.opt.laststatus = 0
vim.api.nvim_set_option("clipboard", "unnamed")

vim.opt.showmode = false
vim.opt.showcmd = true

-- Stolen from https://github.com/rcmoret/neovim_config/blob/main/lua/config/options.lua, keep and remove as needed
-- vim.opt.mouse = ""
-- vim.opt.ignorecase = false

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true
-- vim.opt.smartindent = true
vim.o.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.iskeyword:append({ "-", "@" })

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1200

vim.opt.history = 10000
vim.opt.background = "dark"
vim.opt.list = true
-- vim.opt.listchars = {
--   tab = "> ",
--   space = " ",
--   trail = "·",
-- }
