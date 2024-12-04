-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Telescope / File explorer
-- vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })

-- vim.keymap.del("n", "<leader>ff")
-- vim.keymap.del("n", "<leader>fw")
-- vim.keymap.del("n", "<leader>fg")

-- Remove default keymaps for Telescope
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        -- To disable a keymap, put [map] = false
        -- So, to not map "<C-n>", just put
        ["<leader>ff"] = false,
        ["<leader>fw"] = false,
        ["<leader>fg"] = false,
        ["<leader><leader>"] = false,
      },
    },
  },
})

-- Add new keymaps for Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Pick files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Pick files tool='git'<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>Pick grep_live<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>Pick resume<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>Pick files<cr>", { noremap = true, silent = true })

-- Code Actions
-- <LEADER>cr - Rename variable
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true })

-- Mini Files
-- vim.keymap.set("n", "<leader>e", function()
--   local MiniFiles = require("mini.files")
--   -- Open mini.files in current file working directory
--   MiniFiles.open(vim.fn.getcwd())
-- end)
-- vim.keymap.set("n", "<leader>e", function()
--   local MiniFiles = require("mini.files")
--
--   -- Function to find the root directory (based on .git or fallback to cwd)
--   local function find_git_root()
--     local git_root = vim.fn.finddir(".git", vim.fn.getcwd() .. ";")
--     if git_root == "" then
--       return vim.fn.getcwd()
--     else
--       return vim.fn.fnamemodify(git_root, ":h")
--     end
--   end
--
--   -- Get the root directory
--   local root_dir = find_git_root()
--
--   -- Toggle Mini Files
--   if MiniFiles.close() then
--     return
--   end
--   MiniFiles.open(vim.fn.getcwd())
--
--   -- Reveal the cwd within the opened Mini Files
--   vim.defer_fn(function()
--     MiniFiles.reveal_cwd()
--   end, 30)
-- end)

-- LSP
vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", { noremap = true, silent = true })

-- Harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<C-a>", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-1>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-2>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-3>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-4>", function()
  harpoon:list():select(4)
end)

-- Project Manager
-- function initProjectManager()
--   local file = io.open(vim.fn.stdpath("config") .. "/project_locations.txt", "r")
--
--   if file == nil then
--     print(
--       "No project_locations.txt file found in your config directory. Please create one and add your project locations."
--     )
--     return
--   end
--
--   local found_projects = {}
--   for line in file:lines() do
--     table.insert(found_projects, line)
--   end
--
--   local project_manager = require("neovim-project").setup({
--     projects = found_projects,
--   })
--
--   vim.keymap.set("n", "<leader>pp", ":Telescope neovim-project discover<CR>", {})
-- end
-- initProjectManager()

vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows right

-- Map <leader>r to run search-replace: :%s/original/replacement
-- End cursor on the original word
-- Description: Search and replace
vim.api.nvim_set_keymap("n", "<leader>r", ":%s//g<left><left>", {
  noremap = true,
  silent = true,
  desc = "Search and Replace",
})

-- Search and replace but use word under cursor as search term
-- Description: Search and replace word under cursor
vim.api.nvim_set_keymap("n", "<leader>R", ":%s/\\<<C-r><C-w>\\>//g<left><left>", {
  noremap = true,
  silent = true,
  desc = "Search and Replace Word Under Cursor",
})

-- Search and replace but use visual selection as search term
-- Description: Search and replace visual selection
vim.api.nvim_set_keymap("v", "<leader>r", ":'<,'>s//g<left><left>", {
  noremap = true,
  silent = true,
  desc = "Search and Replace Visual Selection",
})

-- Search and replace but use visual selection as search term
-- Description: Search and replace visual selection
vim.api.nvim_set_keymap("v", "<leader>R", ":'<,'>s/\\<<C-r><C-w>\\>//g<left><left>", {
  noremap = true,
  silent = true,
  desc = "Search and Replace Visual Selection",
})

-- Movement
local keyset = vim.keymap.set
keyset("i", "jk", "<esc>")

keyset("v", "J", ":m '>+1<cr>gv=gv")
keyset("v", "K", ":m '<-2<cr>gv=gv")
keyset("n", "<space>h", "<c-w>h")
keyset("n", "<space>j", "<c-w>j")
keyset("n", "<space>k", "<c-w>k")
keyset("n", "<space>l", "<c-w>l")
keyset("n", "<leader>wh", "<c-w>t<c-h>H")
keyset("n", "<leader>wk", "<c-w>t<c-h>K")
keyset("n", "<down>", ":resize +5<cr>")
keyset("n", "<up>", ":resize -5<cr>")
keyset("n", "<right>", ":vertical resize +5<cr>")
keyset("n", "<left>", ":vertical resize -5<cr>")
keyset("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
keyset("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- Tiny Code Actions
-- vim.api.nvim_set_keymap("n", "<leader>ca", function()
--   require("tiny-code-action").code_action()
-- end, { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<leader>ca",
  "<cmd>lua require('tiny-code-action').code_action()<cr>",
  { noremap = true, silent = true }
)

-- Project Explorer
vim.api.nvim_set_keymap(
  "n",
  "<leader>pp",
  "<cmd>ProjectExplorer<CR>",
  { noremap = true, silent = true, desc = "Open Project Explorer" }
)

-- Persistence
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end)

vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end)

vim.keymap.set("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end)

vim.keymap.set("n", "<leader>qd", function()
  require("persistence").stop()
end)

-- LSP Saga
vim.api.nvim_set_keymap(
  "n",
  "<C-i>",
  "<cmd>Lspsaga finder<cr>",
  { noremap = true, silent = true, desc = "LSP Saga finder" }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-n>",
  "<cmd>Lspsaga show_cursor_diagnostics<cr>",
  { noremap = true, silent = true, desc = "LSP Saga show_cursor_diagnostics" }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-k>",
  "<cmd>Lspsaga peek_definition<cr>",
  { noremap = true, silent = true, desc = "LSP Saga peek_definition" }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-j>",
  "<cmd>Lspsaga code_action<cr>",
  { noremap = true, silent = true, desc = "LSP Saga code_action" }
)

-- DevDocs
vim.api.nvim_set_keymap("n", "<C-d>", "<cmd>DevdocsOpen<cr>", { noremap = true, silent = true, desc = "Open DevDocs" })

vim.api.nvim_set_keymap(
  "n",
  "[d",
  "<cmd>Lspsaga diagnostic_jump_prev<cr>",
  { noremap = true, silent = true, desc = "Jump to previous diagnostic" }
)

vim.api.nvim_set_keymap(
  "n",
  "]d",
  "<cmd>Lspsaga diagnostic_jump_next<cr>",
  { noremap = true, silent = true, desc = "Jump to next diagnostic" }
)

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open("default")
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec('"normal! \\<RightMouse>"')

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- Increment and Decrement numbers
vim.api.nvim_set_keymap("n", "<C-a>", "<C-a>", { noremap = true, silent = true, desc = "Increment number" })
vim.api.nvim_set_keymap("n", "<C-x>", "<C-x>", { noremap = true, silent = true, desc = "Decrement number" })

vim.api.nvim_set_keymap(
  "n",
  "<C-s>",
  "<cmd>SessionSearch<cr>",
  { noremap = true, silent = true, desc = "Session Search" }
)

-- Run StartProject
vim.api.nvim_set_keymap(
  "n",
  "<leader>ps",
  "<cmd>lua StartProject()<cr>",
  { noremap = true, silent = true, desc = "Start Project" }
)

-- Helper function to arrange buffers with the center pane larger
function arrange_buffers()
  local buffers = vim.fn.getbufinfo({ buflisted = true })
  if #buffers < 3 then
    print("Not enough buffers")
    return
  end

  -- Get the 3 most recent buffers
  local recent_buffers = { buffers[#buffers - 2].bufnr, buffers[#buffers - 1].bufnr, buffers[#buffers].bufnr }

  -- Open each buffer in a vertical split and capture window IDs
  vim.cmd("vsplit")
  vim.cmd("vsplit")
  vim.cmd("b " .. recent_buffers[1])
  local win1 = vim.api.nvim_get_current_win()
  vim.cmd("wincmd h")
  vim.cmd("b " .. recent_buffers[2])
  local win2 = vim.api.nvim_get_current_win()
  vim.cmd("wincmd l")
  vim.cmd("b " .. recent_buffers[3])
  local win3 = vim.api.nvim_get_current_win()

  -- Resize the panes by navigating to each window directly
  vim.api.nvim_set_current_win(win1)
  vim.cmd("vertical resize 40") -- Set left pane width to 40

  vim.api.nvim_set_current_win(win2)
  vim.cmd("vertical resize 80") -- Set center pane width to 80

  vim.api.nvim_set_current_win(win3)
  vim.cmd("vertical resize 40") -- Set right pane width to 40
end

-- Helper function to toggle layout
function toggle_layout()
  if vim.g.center_layout_active then
    vim.cmd("wincmd =") -- Equalize all windows
    vim.g.center_layout_active = false
  else
    arrange_buffers() -- Arrange with a larger center pane
    vim.g.center_layout_active = true
  end
end

-- Keymaps to trigger the layout change and toggle
vim.api.nvim_set_keymap("n", "<leader>3buf", ":lua arrange_buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>toggle", ":lua toggle_layout()<CR>", { noremap = true, silent = true })

-- Keymap to reload the config
vim.api.nvim_set_keymap(
  "n",
  "<leader>rr",
  ':source $MYVIMRC<CR>:lua print("Config reloaded!")<CR>',
  { noremap = true, silent = true }
)
