local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable default Telescope keymaps
-- vim.keymap.del('n', '<leader>ff')
-- vim.keymap.del('n', '<leader>fw')
-- vim.keymap.del('n', '<leader>fg')
-- vim.keymap.del('n', '<leader><leader>')

-- File Picker with mini.pick
map('n', '<leader>ff', function()
  require('mini.pick').builtin.files()
end, opts)

-- Word Search with mini.pick
map('n', '<leader>fw', function()
  require('mini.pick').builtin.grep_live()
end, opts)

-- Git Files Search with mini.pick
map('n', '<leader>fg', function()
  require('mini.pick').builtin.git_files()
end, opts)

-- Buffer Picker with mini.pick
vim.keymap.set('n', '<leader><leader>', function()
  local pick = require 'mini.pick'
  local fs = vim.fs

  local root = fs.dirname(fs.find({ 'composer.json', '.git' }, { upward = true })[1] or vim.loop.cwd())

  pick.builtin.files { cwd = root }
end, { desc = 'Find file (project root)' })

-- Additional useful mappings
map('n', '<leader>q', ':q<CR>', opts) -- Quit
map('n', '<leader>w', ':w<CR>', opts) -- Save file
map('n', '<leader>x', ':x<CR>', opts) -- Save and exit
map('n', '<leader>h', ':nohlsearch<CR>', opts) -- Clear search highlight

-- Window Navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Buffer Navigation
map('n', '<Tab>', ':bnext<CR>', opts)
map('n', '<S-Tab>', ':bprevious<CR>', opts)

-- Splitting Windows
map('n', '<leader>sv', ':vsplit<CR>', opts)
map('n', '<leader>sh', ':split<CR>', opts)

-- Move Lines
map('n', '<A-j>', ':m .+1<CR>==', opts)
map('n', '<A-k>', ':m .-2<CR>==', opts)

-- Use H for previous buffer, L for next buffer
vim.keymap.set('n', 'H', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'L', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- Open LazyGit
vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })

-- Open Yazi with <leader>e
vim.keymap.set('n', '<leader>e', '<cmd>Yazi<cr>', { desc = 'Open Yazi' })

-- LSP Mappings
vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol' })
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = 'Go to references' })
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Show hover documentation' })
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code action' })
vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { desc = 'Format code' })
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Go to implementation' })

vim.keymap.set('n', '<Esc>', function()
  if vim.v.hlsearch == 1 then
    vim.cmd 'nohlsearch'
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
  end
end, { noremap = true, silent = true })
