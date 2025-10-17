local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Disable default Telescope keymaps
-- vim.keymap.del('n', '<leader>ff')
-- vim.keymap.del('n', '<leader>fw')
-- vim.keymap.del('n', '<leader>fg')
-- vim.keymap.del('n', '<leader><leader>')

-- File Picker with mini.pick
map("n", "<leader>ff", function()
	require("mini.pick").builtin.files()
end, opts)

-- Filtered grep: exclude common noisy files/folders
vim.keymap.set("n", "<leader>fw", function()
	require("mini.pick").builtin.grep_live({
		globs = {
			"!**/node_modules/**",
			"!**/languages/**",
			"!**/vendor/**",
			"!**/yarn.lock",
			"!**/package-lock.json",
			"!**/composer.lock",
			"!**/*.lock",
			"!**/*.po",
		},
	})
end, { desc = "Live Grep (filtered)" })

-- Full live grep (no exclusions)
vim.keymap.set("n", "<leader>fW", function()
	require("mini.pick").builtin.grep_live()
end, { desc = "Live Grep (ALL files)" })

-- Git Files Search with mini.pick
map("n", "<leader>fg", function()
	require("mini.pick").builtin.git_files()
end, opts)

-- Buffer Picker with mini.pick
-- vim.keymap.set("n", "<leader><leader>", function()
-- 	local pick = require("mini.pick")
-- 	local fs = vim.fs
--
-- 	local root = fs.dirname(fs.find({ "composer.json", ".git" }, { upward = true })[1] or vim.loop.cwd())
--
-- 	pick.builtin.files({ cwd = root })
-- end, { desc = "Find file (project root)" })

-- Additional useful mappings
map("n", "<leader>q", ":q<CR>", opts) -- Quit
map("n", "<leader>w", ":w<CR>", opts) -- Save file
map("n", "<leader>x", ":x<CR>", opts) -- Save and exit
map("n", "<leader>h", ":nohlsearch<CR>", opts) -- Clear search highlight

-- Window Navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
-- map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Buffer Navigation
-- map('n', '<Tab>', ':bnext<CR>', opts)
-- map('n', '<S-Tab>', ':bprevious<CR>', opts)

vim.keymap.del("i", "<Tab>")

-- Splitting Windows
map("n", "<leader>sv", ":vsplit<CR>", opts)
map("n", "<leader>sh", ":split<CR>", opts)

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

-- Use H for previous buffer, L for next buffer
vim.keymap.set("n", "H", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Open neogit
local neogit = require("neogit")
vim.keymap.set("n", "<leader>gg", function()
	neogit.open({ kind = "split_above" })
end, { desc = "Open Neogit" })

-- Open Yazi with <leader>e
-- vim.keymap.set("n", "<leader>e", "<cmd>Yazi<cr>", { desc = "Open Yazi" })

local lsp_keymaps_enabled = false

if lsp_keymaps_enabled then
	-- LSP Mappings
	local legacy_lsp = false
	if legacy_lsp then
		-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature help" })
		-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show hover documentation" })
		vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
		vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" })
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "Go to references" })
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Go to declaration" })
		-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Go to implementation' })
	end

	-- vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', { desc = 'Format code' })

	-- LSP Saga

	if not legacy_lsp then
		-- Hover Doc (replaces vim.lsp.buf.hover)
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP Hover Docs", silent = true })

		-- Peek Definition (floating window)
		vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition", silent = true })

		-- Go to Definition
		vim.keymap.set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Definition", silent = true })

		-- Find References
		vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder", silent = true })

		-- Rename
		-- vim.keymap.set('n', '<leader>cr', '<cmd>Lspsaga rename<CR>', { desc = 'Rename Symbol', silent = true })

		-- Code Action
		-- vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code Action', silent = true })

		-- Diagnostic Jump
		vim.keymap.set(
			"n",
			"[d",
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			{ desc = "Previous Diagnostic", silent = true }
		)
		vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic", silent = true })

		-- Outline View
		vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Outline", silent = true })

		-- Show Line Diagnostics
		vim.keymap.set(
			"n",
			"<leader>sl",
			"<cmd>Lspsaga show_line_diagnostics<CR>",
			{ desc = "Line Diagnostics", silent = true }
		)

		-- Show Cursor Diagnostics
		vim.keymap.set(
			"n",
			"<leader>sc",
			"<cmd>Lspsaga show_cursor_diagnostics<CR>",
			{ desc = "Cursor Diagnostics", silent = true }
		)

		-- Float Terminal
		vim.keymap.set(
			{ "n", "t" },
			"<A-d>",
			"<cmd>Lspsaga term_toggle<CR>",
			{ desc = "Toggle Terminal", silent = true }
		)
	end
end

vim.keymap.set("n", "<Esc>", function()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch")
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
	end
end, { noremap = true, silent = true })

-- local lspopts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', lspopts)
-- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', lspopts)
-- vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', lspopts)
-- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', lspopts)
-- vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', lspopts)
-- vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', lspopts)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })

vim.keymap.set({ "n", "x" }, "<leader>a", '<cmd>lua require("fastaction").code_action()<CR>', { buffer = bufnr })

vim.keymap.set({ "n", "x" }, "<leader>a", '<cmd>lua require("fastaction").code_action()<CR>', { buffer = bufnr })
vim.keymap.set("n", "<leader>ca", '<cmd>lua require("fastaction").code_action()<CR>', { desc = "Code action" })
vim.keymap.set("n", "<leader>f", "*N", { desc = "Search word under cursor (stay on current match)" })

-- Diagnostics
-- vim.keymap.set('n', '<leader>dl', function()
--   local line = vim.api.nvim_win_get_cursor(0)[1] - 1
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--   local diagnostics = vim.diagnostic.get(0, { lnum = line })
--
--   for _, d in ipairs(diagnostics) do
--     if d.col > col then
--       vim.api.nvim_win_set_cursor(0, { line + 1, d.col })
--       return
--     end
--   end
--   print 'No next diagnostic on this line'
-- end, { desc = 'Next diagnostic on line' })

vim.keymap.set("n", "<leader>dn", function()
	vim.diagnostic.goto_next()
	require("fastaction").code_action()
end, { desc = "Next diagnostic + code action" })

vim.keymap.set("n", "<leader>dp", function()
	vim.diagnostic.goto_prev()
end, {})

vim.keymap.set("n", "<leader>ci", function()
	local pairs = { ["("] = ")", ["["] = "]", ["{"] = "}", ["<"] = ">", ['"'] = '"', ["'"] = "'", ["`"] = "`" }
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()

	local open_idx, open_char
	for i = col, 1, -1 do
		local c = line:sub(i, i)
		if pairs[c] then
			open_idx = i
			open_char = c
			break
		end
	end

	if not open_idx then
		vim.cmd("normal! ciw")
		return
	end

	local close_char = pairs[open_char]
	local close_idx = line:find(vim.pesc(close_char), open_idx + 1)

	if close_idx then
		-- Move cursor to the opening character
		vim.api.nvim_win_set_cursor(0, { row, open_idx - 1 })
		vim.cmd("normal! ci" .. open_char)
	else
		vim.cmd("normal! ciw")
	end
end, { desc = "Change inside nearest surrounding pair" })

vim.keymap.set("n", "<leader>,", "mzA,<Esc>`z", { desc = "add comma to end of line" })
vim.keymap.set("n", "<leader>;", "mzA;<Esc>`z", { desc = "add semicolon to end of line" })

-- vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
--   require('tiny-code-action').code_action()
-- end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" })

-- local newsflash = require 'newsflash'
-- vim.keymap.set('n', '<leader>q', newsflash.toggle)

-- Spectre
if pcall(require, "spectre") then
	vim.keymap.set("n", "<leader>sr", '<cmd>lua require("spectre").toggle()<CR>', {
		desc = "Toggle Spectre",
	})
else
	local Terminal = require("toggleterm.terminal").Terminal
	local scooter_term = nil

	-- Open existing scooter terminal if one is available, otherwise create a new one
	local function open_scooter()
		if not scooter_term then
			scooter_term = Terminal:new({
				cmd = "scooter",
				direction = "float",
				close_on_exit = true,
				on_exit = function()
					scooter_term = nil
				end,
			})
		end
		scooter_term:open()
	end

	-- Called by scooter to open the selected file at the correct line from the scooter search list
	_G.EditLineFromScooter = function(file_path, line)
		if scooter_term and scooter_term:is_open() then
			scooter_term:close()
		end

		local current_path = vim.fn.expand("%:p")
		local target_path = vim.fn.fnamemodify(file_path, ":p")

		if current_path ~= target_path then
			vim.cmd.edit(vim.fn.fnameescape(file_path))
		end

		vim.api.nvim_win_set_cursor(0, { line, 0 })
	end

	-- Opens scooter with the search text populated by the `search_text` arg
	_G.OpenScooterSearchText = function(search_text)
		if scooter_term and scooter_term:is_open() then
			scooter_term:close()
		end

		local escaped_text = vim.fn.shellescape(search_text:gsub("\r?\n", " "))
		scooter_term = Terminal:new({
			cmd = "scooter --search-text " .. escaped_text,
			direction = "float",
			close_on_exit = true,
			on_exit = function()
				scooter_term = nil
			end,
		})
		scooter_term:open()
	end

	vim.keymap.set("n", "<leader>s", open_scooter, { desc = "Open scooter" })

	vim.keymap.set(
		"v",
		"<leader>r",
		'"ay<ESC><cmd>lua OpenScooterSearchText(vim.fn.getreg("a"))<CR>',
		{ desc = "Search selected text in scooter" }
	)
end
