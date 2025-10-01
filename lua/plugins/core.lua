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
					progress = { enabled = false }, -- Turn off LSP progress
					signature = { enabled = false }, -- Turn off signature help
					hover = { enabled = false }, -- Turn off hover
					message = { enabled = false }, -- Turn off LSP messages
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

				-- UI tweaks (feel free to tweak further!)
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

	-- CMP (completion)
	{
		"Saghen/blink.cmp",
		event = "InsertEnter",
		version = "*", -- ✅ this makes it track stable tags, not commits
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("core.cmp")
		end,
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
			enabled = false, -- If you want to enable the plugin
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
	{
		"nvim-pack/nvim-spectre",
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
}
