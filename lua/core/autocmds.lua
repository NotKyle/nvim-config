local api = vim.api
local fn = vim.fn
local o = vim.o

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

local function check_file_changed()
	api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
		callback = function()
			if o.modifiable and not o.readonly then
				if fn.getcmdwintype() == "" then
					vim.cmd("checktime")
				end
			end
		end,
	})
end

local function setup_formatters()
	api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.css", "*.scss", "*.md", "*.json", "*.yaml", "*.yml" },
		callback = function()
			vim.lsp.buf.format({ async = false })
		end,
	})
end

-- highlight on yank
local function setup_yank_highlight()
	api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
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
	check_file_changed()
	-- setup_formatters()
	setup_yank_highlight()
	resize_splits()
end

setup_autocmds()
