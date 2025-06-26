vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.lazy")  -- ⬅️ Must come BEFORE anything else
require("core")       -- ⬅️ Loads your actual config (options, keymaps, etc.)

