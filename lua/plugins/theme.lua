return {
	{
		"lewis6991/hover.nvim",
		enable = false,
		config = function()
			require("hover").config({
				--- List of modules names to load as providers.
				--- @type (string|Hover.Config.Provider)[]
				providers = {
					"hover.providers.diagnostic",
					"hover.providers.lsp",
					"hover.providers.dap",
					"hover.providers.man",
					"hover.providers.dictionary",
					-- Optional, disabled by default:
					"hover.providers.gh",
					"hover.providers.gh_user",
					"hover.providers.jira",
					"hover.providers.fold_preview",
					"hover.providers.highlight",
				},
				preview_opts = {
					border = "single",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = true,
				title = true,
				mouse_providers = {
					"hover.providers.lsp",
				},
				mouse_delay = 1000,
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", function()
				require("hover").open()
			end, { desc = "hover.nvim (open)" })

			vim.keymap.set("n", "gK", function()
				require("hover").enter()
			end, { desc = "hover.nvim (enter)" })

			vim.keymap.set("n", "<C-p>", function()
				require("hover").hover_switch("previous")
			end, { desc = "hover.nvim (previous source)" })

			vim.keymap.set("n", "<C-n>", function()
				require("hover").hover_switch("next")
			end, { desc = "hover.nvim (next source)" })

			-- Mouse support
			vim.keymap.set("n", "<MouseMove>", function()
				require("hover").mouse()
			end, { desc = "hover.nvim (mouse)" })

			vim.o.mousemoveevent = true
		end,
	},
	{
		-- Overall theme
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				dim_inactive_windows = true,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				palette = {
					-- Override the builtin palette per variant
					-- moon = {
					--   base = '#18191a',
					--   overlay = '#363738',
					-- },
				},

				-- NOTE: Highlight groups are extended (merged) by default. Disable this
				-- per group via `inherit = false`
				-- highlight_groups = {
				--   Comment = { fg = 'foam' },
				--   StatusLine = { fg = 'love', bg = 'love', blend = 15 },
				--   VertSplit = { fg = 'muted', bg = 'muted' },
				--   Visual = { fg = 'base', bg = 'text', inherit = false },
				-- },

				-- before_highlight = function(group, highlight, palette)
				--   -- Disable all undercurls
				--   if highlight.undercurl then
				--     highlight.undercurl = false
				--   end
				--
				--   -- Change palette colour
				--   if highlight.fg == palette.pine then
				--     highlight.fg = palette.foam
				--   end
				-- end,
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
}
