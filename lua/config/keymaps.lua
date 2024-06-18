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
vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>Pick files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Pick files tool='git'<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>Pick grep_live<cr>", { noremap = true, silent = true })

-- Code Actions
-- <LEADER>cr - Rename variable
vim.api.nvim_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true })

-- Mini Files
vim.keymap.set("n", "<leader>e", "<cmd>lua require('mini.files').open()<cr>")

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

vim.keymap.set("n", "<leader>a", function()
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
function initProjectManager()
  local file = io.open(vim.fn.stdpath("config") .. "/project_locations.txt", "r")

  if file == nil then
    print(
      "No project_locations.txt file found in your config directory. Please create one and add your project locations."
    )
    return
  end

  local found_projects = {}
  for line in file:lines() do
    table.insert(found_projects, line)
  end

  local project_manager = require("neovim-project").setup({
    projects = found_projects,
  })

  vim.keymap.set("n", "<leader>pp", ":Telescope neovim-project discover<CR>", {})
end
initProjectManager()
