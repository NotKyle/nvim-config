-- Path to the debug log
local log_path = vim.fn.stdpath("data") .. "/nvim_debug.log"

-- Silent logging function with timestamp and file info
local function log(msg)
	-- Get current time
	local time = os.date("%Y-%m-%d %H:%M:%S")
	-- Get current buffer name
	local file = vim.api.nvim_buf_get_name(0)
	-- Format message
	local entry = string.format("[%s] [%s] %s", time, file ~= "" and file or "N/A", msg)

	-- Append to log file
	local f = io.open(log_path, "a")
	if f then
		f:write(entry .. "\n")
		f:close()
	end
end

-- Command to open the log
vim.api.nvim_create_user_command("OpenLSPLog", function()
	vim.cmd("edit " .. log_path)
end, {})

-- FileType autocmd to enable LSPs with logging
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "lua", "php", "html", "css" },
-- 	callback = function(args)
-- 		local ft = args.match
-- 		local map = {
-- 			lua = "luals",
-- 			php = "intelephense",
-- 			html = "html",
-- 			css = "cssls",
-- 		}
--
-- 		-- Enable the "primary" LSP for the filetype
-- 		local server = map[ft]
-- 		if server then
-- 			log("Enabling LSP for " .. ft .. " using " .. server)
-- 			vim.lsp.enable(server)
-- 		end
--
-- 		-- Always enable tailwindcss in supported filetypes
-- 		local tailwind_filetypes = { "html", "css", "php" }
-- 		if vim.tbl_contains(tailwind_filetypes, ft) then
-- 			log("Enabling Tailwind LSP in " .. ft)
-- 			vim.lsp.enable("tailwindcss")
-- 		end
-- 	end,
-- })

-- Load our LSPs :)
vim.lsp.enable("luals")
vim.lsp.enable("intelephense")
-- vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("tailwindcss")
