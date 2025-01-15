vim.env.PHP_CS_FIXER_IGNORE_ENV = '1'

vim.opt.showtabline = 0
vim.opt.laststatus = 0
vim.opt.clipboard = 'unnamedplus'
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indentation
-- vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
-- vim.opt.autoindent = true
-- vim.opt.smarttab = true
-- End Indentation

vim.opt.scrolloff = 8
vim.opt.swapfile = false

-- Backup and Undo
vim.opt.backup = true
vim.opt.backupdir = os.getenv 'HOME' .. '/.vim/backup//'
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.autoread = true

vim.opt.iskeyword:append { '-', '@' }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.history = 10000
vim.opt.background = 'dark'
vim.opt.list = true
vim.opt.listchars = {
  tab = '› ',
  trail = '·',
  extends = '⟩',
  precedes = '⟨',
}
-- space = "·",

vim.opt.iskeyword:append { '-', '@' }

vim.cmd [[filetype plugin indent on]]

vim.cmd [[ set foldmethod=manual ]]

return {}
