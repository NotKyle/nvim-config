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
vim.keymap.set("n", "<leader><leader>", function()
  local pick = require("mini.pick")
  local fs = vim.fs

  local root = fs.dirname(
    fs.find({ "composer.json", ".git" }, { upward = true })[1]
    or vim.loop.cwd()
  )

  pick.builtin.files({ cwd = root })
end, { desc = "Find file (project root)" })

-- Additional useful mappings
map('n', '<leader>q', ':q<CR>', opts)          -- Quit
map('n', '<leader>w', ':w<CR>', opts)          -- Save file
map('n', '<leader>x', ':x<CR>', opts)          -- Save and exit
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
-- map('v', '<A-j>', ':m '>+1<CR>gv=gv', opts)
-- map('v', '<A-k>', ':m '<-2<CR>gv=gv', opts)
-- -- Stay in indent mode
-- map('v', '<', '<gv', opts)
-- map('v', '>', '>gv', opts)
