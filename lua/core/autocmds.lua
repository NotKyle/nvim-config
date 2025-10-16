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

-- For PHP only, replace 'period' with '->' in insert mode when the context is appropriate (such as after a variable or object)
local function php_object_operator()
	api.nvim_create_autocmd("InsertCharPre", {
		pattern = "*.php",
		callback = function()
			-- when we hit . replace with ->
			-- dont run inside a comment or string

			if vim.v.char == "." then
				local context = fn.synIDattr(fn.synID(fn.line("."), fn.col(".") - 1, true), "name")
				if context:match("Comment") or context:match("String") then
					return
				end

				local prev_char = fn.getline("."):sub(fn.col(".") - 1, fn.col(".") - 1)
				if prev_char:match("[%w_]") then
					vim.schedule(function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>->", true, false, true), "n", true)
					end)
				end
			end
		end,
	})
end

local function setup_autocmds()
	php_object_operator()
	restore_cursor_position()
	highlight_yank()
	trim_whitespace()
	resize_splits()
end

setup_autocmds()
