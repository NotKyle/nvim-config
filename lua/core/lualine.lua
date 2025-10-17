-- run lualine after all plugins are loaded
function lualine()
	local function recording_component()
		local reg = vim.fn.reg_recording()
		if reg == "" then
			return ""
		end
		return "⏺ Recording (@" .. reg .. ")"
	end

	local function recording_color()
		if vim.fn.reg_recording() ~= "" then
			return { fg = "#ffffff", bg = "#ff5f5f", gui = "bold" } -- white on red
		end
		return {} -- default
	end

	local function loc_count()
		local total_lines = vim.fn.line("$")
		local current_line = vim.fn.line(".")
		return "� " .. current_line .. "/" .. total_lines
	end

	local function lsp_status()
		-- Show LSP status
		local clients = vim.lsp.get_clients()
		if #clients == 0 then
			return "No LSP"
		end
		local client_names = {}
		for _, client in ipairs(clients) do
			table.insert(client_names, client.name)
		end
		return "LSP: " .. table.concat(client_names, ", ")
	end

	require("lualine").setup({
		options = {
			theme = "rose-pine",
		},
		sections = {
			lualine_c = {
				{
					recording_component,
					color = recording_color,
				},
				{
					loc_count,
					color = { fg = "#c792ea", gui = "bold" }, -- purple
				},
			},
			-- other sections (like lualine_x, lualine_y, etc)
			lualine_y = {
				{
					lsp_status,
					color = { fg = "#89b4fa", gui = "bold" }, -- blue
				},
			},
		},
	})
end

lualine()
