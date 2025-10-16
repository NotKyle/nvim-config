---@diagnostic disable: undefined-doc-name
return {
	-- Noice (UI)
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000", -- Solid black background for notify popups
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				-- Turn off UI extras for LSP
				lsp = {
					progress = { enabled = false },
					signature = { enabled = false },
					hover = { enabled = false },
					message = { enabled = false },
				},

				-- Filter noisy messages even more aggressively
				routes = {
					-- Suppress generic LSP messages
					{
						filter = { event = "lsp" },
						opts = { skip = true },
					},

					-- Suppress common notify popups
					{
						filter = {
							event = "notify",
							any = {
								{ find = "written" },
								{ find = "change" },
								{ find = "successfully" },
								{ find = "Already installed" },
								{ find = "No information available" },
							},
						},
						opts = { skip = true },
					},

					-- Suppress "written" messages from :w
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},

					-- Suppress yank messages
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "yanked",
						},
						opts = { skip = true },
					},

					-- Suppress delete messages like "3 lines deleted"
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "deleted",
						},
						opts = { skip = true },
					},

					-- Suppress search hit bottom/top messages
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "search hit",
						},
						opts = { skip = true },
					},
				},

				-- Only show WARN and ERROR level notifications
				notify = {
					enabled = true,
					view = "mini",
					level = vim.log.levels.WARN,
				},

				-- UI tweaks
				presets = {
					bottom_search = false,
					command_palette = false,
					long_message_to_split = false,
					inc_rename = false,
					lsp_doc_border = false,
				},
			})
		end,
	},

	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat",
		},
	},

	-- Treesitter & extras
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.blade = {
				install_info = {
					url = "https://github.com/EmranMR/tree-sitter-blade",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "blade",
			}

			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"php",
					"html",
					"css",
					"scss",
					"javascript",
					"json",
				},
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3,
				separator = "-",
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- UI
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "folke/snacks.nvim", config = true },

	-- Telescope (no keymaps)
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Productivity
	{ "folke/todo-comments.nvim", config = true },
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{ "folke/trouble.nvim", config = true },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = true,
	},

	-- Yazi integration
	{
		"mikavilpas/yazi.nvim",
		cmd = { "Yazi", "YaziHere" },
		config = true,
	},
	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
		},
		---@type TailwindTools.Option
		opts = {
			server = {
				override = true, -- setup the server from the plugin if true
				settings = {}, -- shortcut for `settings.tailwindCSS`
				on_attach = function(client, bufnr) end, -- callback triggered when the server attaches to a buffer
			},
			document_color = {
				enabled = true, -- can be toggled by commands
				kind = "inline", -- "inline" | "foreground" | "background"
				inline_symbol = "󰝤 ", -- only used in inline mode
				debounce = 200, -- in milliseconds, only applied in insert mode
			},
			conceal = {
				enabled = false, -- can be toggled by commands
				min_length = nil, -- only conceal classes exceeding the provided length
				symbol = "󱏿", -- only a single character is allowed
				highlight = { -- extmark highlight options, see :h 'highlight'
					fg = "#38BDF8",
				},
			},
			cmp = {
				highlight = "foreground", -- color preview style, "foreground" | "background"
			},
			telescope = {
				utilities = {
					callback = function(name, class) end, -- callback used when selecting an utility class in telescope
				},
			},
			-- see the extension section to learn more
			extension = {
				queries = {}, -- a list of filetypes having custom `class` queries
				patterns = { -- a map of filetypes to Lua pattern lists
					-- example:
					-- rust = { "class=[\"']([^\"']+)[\"']" },
					-- javascript = { "clsx%(([^)]+)%)" },
				},
			},
		},
	},
	-- Prioritise window
	{
		"zimeg/newsflash.nvim",
		event = "VeryLazy",
		config = function()
			local newsflash = require("newsflash")
			vim.keymap.set("n", "<leader>q", newsflash.toggle)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					priority = 15,
					style = {
						{ fg = "#ca9ee6" },
						{ fg = "#e78284" },
					},
					use_treesitter = true,
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
					textobject = "",
					max_file_size = 1024 * 1024,
					error_sign = true,
					-- animation related
					duration = 20,
					delay = 1,
				},
				indent = {
					enable = true,
					priority = 10,
					style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
					use_treesitter = false,
					chars = { "│" },
					ahead_lines = 5,
					delay = 1,
				},
			})
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_enable_last_session = false,
				auto_session_enabled = true,
				auto_save_enabled = true,
				auto_restore_enabled = true,
				session_lens = { load_on_setup = false },
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },

				-- Save sessions based on the project directory
				session_dir = vim.fn.stdpath("data") .. "/sessions/",
			})
		end,
	},
	{
		"onsails/lspkind.nvim",
		config = function()
			-- setup() is also available as an alias
			require("lspkind").init({
				-- DEPRECATED (use mode instead): enables text annotations
				--
				-- default: true
				-- with_text = true,

				-- defines how annotations are shown
				-- default: symbol
				-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
				mode = "symbol_text",

				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		enabled = true,
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},

	{
		"github/copilot.vim",
		event = "InsertEnter",
		enabled = false,
	},

	{
		"copilotlsp-nvim/copilot-lsp",
		init = function()
			vim.g.copilot_nes_debounce = 500
			vim.lsp.config("copilot", {
				on_init = function(client)
					vim.api.nvim_set_hl(0, "NesAdd", { link = "DiffAdd", default = true })
					vim.api.nvim_set_hl(0, "NesDelete", { link = "DiffDelete", default = true })
					vim.api.nvim_set_hl(0, "NesApply", { link = "DiffText", default = true })

					local au = vim.api.nvim_create_augroup("copilot-language-server", { clear = true })

					--NOTE: didFocus
					vim.api.nvim_create_autocmd("BufEnter", {
						callback = function()
							local td_params = vim.lsp.util.make_text_document_params()
							client:notify("textDocument/didFocus", {
								textDocument = {
									uri = td_params.uri,
								},
							})
						end,
						group = au,
					})

					vim.keymap.set("n", "<leader>rn", function()
						require("copilot-lsp.nes").request_nes(client)
					end)
				end,
			})
			vim.lsp.enable("copilot")
			vim.keymap.set("n", "<tab>", function()
				require("copilot-lsp.nes").apply_pending_nes()
			end)
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		requires = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				vim.g.copilot_nes_debounce = 800
			end,
		},
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				nes = {
					enabled = false,
					keymap = {
						accept_and_goto = "<leader>p",
						accept = false,
						dismiss = "<Esc>",
					},
				},
			})
		end,
	},

	{
		"Chaitanyabsprip/fastaction.nvim",
		config = function()
			require("fastaction").setup({
				keys = "abcdefghijklmnopqrstuvwxyz1234567890", -- Expanded to avoid missing key errors
				max_items = 20,
			})
		end,
	},
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				animate = {
					enabled = false,
					timeout = 100,
					easing = "linear",
				},
			})
		end,
	},
	{
		"f-person/git-blame.nvim",
		opts = {
			enabled = true, -- If you want to enable the plugin
			message_template = " <summary> • <date> • <author> • <<sha>>", -- Template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- Template for the date, check Date format section for more options
			virtual_text_column = 1, -- Virtual text start column, check Start virtual text at column section for more options
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		opts = {},
	},
	{
		"olrtg/nvim-emmet",
		enabled = true,
		config = function()
			vim.keymap.set({ "n", "v", "i" }, "<C-y>", require("nvim-emmet").wrap_with_abbreviation)
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup()
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},

	{
		"fei6409/log-highlight.nvim",
		config = function()
			require("log-highlight").setup({})
		end,
	},

	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"nvim-mini/mini.pick", -- optional
			"folke/snacks.nvim", -- optional
		},
	},

	-- Search & Replace
	{
		"nvim-pack/nvim-spectre",
		enabled = false,
	},

	{
		"thomasschafer/scooter",
		dependencies = { "akinsho/toggleterm.nvim" },
	},

	{
		"mihaifm/megatoggler",
		config = function()
			require("megatoggler").setup({
				tabs = {
					{
						-- global options you might want to persist
						id = "Globals",
						items = {
							{
								id = "Ignore Case",
								-- all items must define a get method
								get = function()
									return vim.o.ignorecase
								end,
								-- items with boolean value must define on_toggle
								on_toggle = function(on)
									vim.o.ignorecase = on
								end,
							},
							{
								id = "Tabstop",
								label = "Tab Stop", -- optional label
								desc = "Tab size", -- optional description
								get = function()
									-- use opt_global for vim options you want to persist
									return vim.opt_global.tabstop:get()
								end,
								-- items with numeric/string value must define on_set
								on_set = function(v)
									vim.opt_global.tabstop = v
								end,
								-- size of the textbox when editing
								edit_size = 3,
							},
							{
								id = "Expand Tab",
								get = function()
									return vim.opt_global.expandtab:get()
								end,
								on_toggle = function(on)
									vim.opt_global.expandtab = on
								end,
							},
							{
								id = "Inc Command",
								get = function()
									return vim.o.inccommand
								end,
								on_set = function(v)
									vim.o.inccommand = v
								end,
								edit_size = 10,
							},
						},
					},
					{
						-- local options you might want to toggle but not persist
						id = "Local",
						items = {
							{
								id = "Tabstop",
								-- disable persistence for buffer-local options
								persist = false,
								get = function()
									return vim.bo.tabstop
								end,
								on_set = function(v)
									vim.bo.tabstop = v
								end,
							},
						},
					},
					{
						-- toggle features provided by other plugins
						id = "Features",
						items = {
							{
								id = "Render Markdown",
								get = function()
									return require("render-markdown").get()
								end,
								on_toggle = function()
									require("render-markdown").toggle()
								end,
							},
							{
								id = "Autopairs",
								get = function()
									-- check if plugin is loaded by Lazy
									-- only needed if you lazy load the plugin
									local lc = require("lazy.core.config")
									if not (lc.plugins["nvim-autopairs"] and lc.plugins["nvim-autopairs"]._.loaded) then
										return false
									end

									return not require("nvim-autopairs").state.disabled
								end,
								on_toggle = function(on)
									-- avoid lazy loading the plugin if on == false
									if on == false then
										local lc = require("lazy.core.config")
										if
											not (lc.plugins["nvim-autopairs"] and lc.plugins["nvim-autopairs"]._.loaded)
										then
											return
										end
									end

									if on then
										require("nvim-autopairs").enable()
									else
										require("nvim-autopairs").disable()
									end
								end,
							},
							{
								id = "Smooth scrolling",
								-- disable persistence when it's difficult to get the plugin's internal state
								persist = false,
								get = function()
									return true
								end,
								on_toggle = function()
									vim.cmd("ToggleNeoscroll")
								end,
								-- set custom icons for plugins where it's difficult to get the state
								icons = { checked = "", unchecked = "" },
							},
						},
					},
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { -- Keys to be mapped to their corresponding default scrolling animation
					"<C-u>",
					"<C-d>",
					"<C-b>",
					"<C-f>",
					"<C-y>",
					"<C-e>",
					"zt",
					"zz",
					"zb",
				},
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				duration_multiplier = 1.0, -- Global duration multiplier
				easing = "linear", -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
				performance_mode = false, -- Disable "Performance Mode" on all buffers.
				ignored_events = { -- Events ignored while scrolling
					"WinScrolled",
					"CursorMoved",
				},
			})
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		-- config = function()
		-- require("refactoring").setup({})
		-- end,
	},

	{
		"saghen/blink.cmp",
		dependencies = { "fang2hou/blink-copilot" },
		-- build = "cargo +nightly build --release",
		version = "*",
		opts = {
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
			sources = {
				default = { "copilot", "lsp", "buffer", "snippets", "path" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
						-- LSP
						lsp = {
							name = "nvim_lsp",
							score_offset = 90,
							async = true,
							priority = 1000, -- Higher priority for LSP suggestions
						},
					},
				},
			},
			keymap = {
				preset = "super-tab",
				["<Tab>"] = {
					function(cmp)
						if vim.b[vim.api.nvim_get_current_buf()].nes_state then
							cmp.hide()
							return (
								require("copilot-lsp.nes").apply_pending_nes()
								and require("copilot-lsp.nes").walk_cursor_end_edit()
							)
						end
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
			signature = { window = { border = "single" } },
			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local mini_icon, _ =
											require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
										if mini_icon then
											return mini_icon .. ctx.icon_gap
										end
									end

									local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from mini.icons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local mini_icon, mini_hl =
											require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
										if mini_icon then
											return mini_hl
										end
									end
									return ctx.kind_hl
								end,
							},
							kind = {
								-- Optional, use highlights from mini.icons
								highlight = function(ctx)
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local mini_icon, mini_hl =
											require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
										if mini_icon then
											return mini_hl
										end
									end
									return ctx.kind_hl
								end,
							},
						},
					},
				},
			},
		},
	},

	{
		"jbuck95/recollect.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },

		config = function()
			require("recollect").setup({
				-- All configuration options are optional.
				-- Below are some examples you can override.

				-- The start date for your grid.
				birthday = "1990-01-01",

				-- The path to your daily notes folder.
				-- IMPORTANT: Make sure to change this to your actual notes path.
				daily_notes_path = vim.fn.expand("~") .. "/Documents/Notes/Dailies",

				-- A function to generate the content for a new daily note.
				note_template = function(date_str)
					local year, month, day = date_str:match("(%d+)-(%d+)-(%d+)")
					local date_obj = os.time({
						year = tonumber(year),
						month = tonumber(month),
						day = tonumber(day),
					})

					local weekdays = {
						"Sunday",
						"Monday",
						"Tuesday",
						"Wednesday",
						"Thursday",
						"Friday",
						"Saturday",
					}

					local months = {
						"January",
						"February",
						"March",
						"April",
						"May",
						"June",
						"July",
						"August",
						"September",
						"October",
						"November",
						"December",
					}

					local wday = tonumber(os.date("%w", date_obj)) + 1
					local formatted_date =
						string.format("%s, %d %s %s", weekdays[wday], tonumber(day), months[tonumber(month)], year)

					return string.format(
						[[---
date: %s
---

### %s

]],
						date_str,
						formatted_date
					)
				end,

				-- You can define custom time periods that get highlighted in the grid.
				periods = {
					{
						start = "2020-03-11",
						finish = "2022-05-01",
						color = "red",
						label = "Pandemic",
					},
				},

				-- Symbols used for notes that have a specific tag in their YAML frontmatter.
				tag_symbols = {
					birthday = "🎂",
					event = "🎉",
					gym = "💪🏼",
					trip = "✈️",
					holiday = "☘",
					party = "🍻",
					work = "💼",
					project = "🛠️",
					deadline = "❗",
					health = "❤️",
					special = "⭐",
				},

				-- Customize the colors of the grid.
				colors = {
					background = "#1e1e2e",
					default_dot = "#45475a",
					today_dot = "#f38ba8",
					note_exists = "#a6e3a1",
					grid_lines = "#313244",
					text = "#cdd6f4",
					year_header = "#89b4fa",
					yellow = "#f9e2af",
					blue = "#89b4fa",
					green = "#a6e3a1",
					red = "#f38ba8",
					purple = "#cba6f7",
					orange = "#fab387",
				},
			})
		end,
	},

	-- Witch Line
	{
		"sontungexpt/witch-line",
		enabled = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		-- opts = {},
		config = function()
			require("witch-line").setup({
				--- @type CombinedComponent[]
				abstract = {
					"file.name",
					{
						id = "file", -- Abstract component for file-related info
						padding = { left = 1, right = 1 }, -- Padding around the component
						static = { some_key = "some_value" }, -- Static metadata
						style = { fg = "#ffffff", bg = "#000000", bold = true }, -- Style override
						min_screen_width = 80, -- Hide if screen width < 80
					},
				},
				--- @type CombinedComponent[]
				components = {
					"mode",
					"file.name",
					"file.icon",
					"file.size",
					"lsp.lua",
					"%=",
					"diagnostic.error",
					"diagnostic.warn",
					"diagnostic.info",
					{
						id = "component_id", -- Unique identifier
						padding = { left = 1, right = 1 }, -- Padding around the component
						static = { some_key = "some_value" }, -- Static metadata
						timing = false, -- No timing updates
						style = { fg = "#ffffff", bg = "#000000", bold = true }, -- Style override
						min_screen_width = 80, -- Hide if screen width < 80
						hidden = function() -- Hide condition
							return vim.bo.buftype == "nofile"
						end,
						left_style = { fg = "#ff0000" }, -- Left style override
						update = function(self, ctx, static, session_id) -- Main content generator
							return vim.fn.expand("%:t")
						end,
						ref = { -- References to other components
							events = { "file.name" },
							style = "file.name",
							static = "file.name",
						},
					},
				},
				-- disabled = {
				-- 	filetypes = { "help", "TelescopePrompt" },
				-- 	buftypes = { "nofile", "terminal" },
				-- },
			})
		end,
	},

	{
		"ptdewey/pendulum-nvim",
		config = function()
			require("pendulum").setup()
		end,
	},
}
