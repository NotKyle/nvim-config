vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "php", "html", "css" },
	callback = function(args)
		local ft = args.match
		local map = {
			lua = "luals",
			php = "intelephense",
			html = "html",
			css = "cssls",
		}
		local server = map[ft]
		if server then
			-- print("Enabling LSP for " .. ft .. " using " .. server)
			vim.lsp.enable(server)
		end
	end,
})
