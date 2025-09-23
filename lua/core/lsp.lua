vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "php", "html", "css" },
	callback = function(args)
		local ft = args.match
		local map = {
			lua = "luals",
			php = "intelephense",
			html = "html",
			css = "cssls",
			harper = "harper",
			tailwindcss = "tailwindcss",
		}
		local server = map[ft]
		if server then
			-- Log the message using Noice but don't show it to the user
			local Noice = require("noice")
			Noice.log.info("Enabling LSP for " .. ft .. " using " .. server)
			-- print("Enabling LSP for " .. ft .. " using " .. server)
			vim.lsp.enable(server)
		end
	end,
})
