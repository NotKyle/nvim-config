local api = vim.api
local fn = vim.fn

local function restore_cursor_position()
	api.nvim_create_autocmd("BufReadPost", {
		callback = function(args)
			local mark = api.nvim_buf_get_mark(args.buf, '"')
			local line_count = api.nvim_buf_line_count(args.buf)
			if mark[1] > 0 and mark[1] <= line_count then
				vim.cmd('normal! g`"zz')
			end
		end,
	})
end

local function highlight_yank()
	api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
		end,
	})
end

local function trim_whitespace()
	api.nvim_create_autocmd("BufWritePre", {
		callback = function()
			local save = fn.winsaveview()
			vim.cmd([[%s/\s\+$//e]])
			fn.winrestview(save)
		end,
	})
end

local function resize_splits()
	api.nvim_create_autocmd("VimResized", {
		callback = function()
			vim.cmd("tabdo wincmd =")
		end,
	})
end

local function setup_autocmds()
	restore_cursor_position()
	highlight_yank()
	trim_whitespace()
	resize_splits()
end

setup_autocmds()