return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true, -- fallback to LSP if no formatter is configured
			},
			formatters_by_ft = {
				lua = { "stylua" },
				php = { "php_cs_fixer" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				sh = { "shfmt" },
				blade = { "blade-formatter" },
			},
		})
	end,
}
