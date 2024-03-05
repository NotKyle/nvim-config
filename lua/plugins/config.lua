-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    'mvllow/stand.nvim',
    config = function()
      minute_interval = 60
    end,
  },

  {
    'coffebar/neovim-project',
    config = function()
      require('neovim-project').setup({
        projects = {
          "~/Desktop/Sites/*"
        },
        vim.keymap.set("n", ";", ":Telescope neovim-project discover<CR>", {}),
      })
    end,
    dependencies = {
      { "Shatur/neovim-session-manager" },
    },
  },
  {
    'natecraddock/workspaces.nvim',
    enabled = true,
    config = function()
      require('workspaces').setup({
        auto_open = true,
      })
    end,
  },

  {
    'mvllow/modes.nvim',
    enabled = true,
    config = function()
      require('modes').setup({
        colors = {
          insert = '#00ff00',
          normal = '#0000ff',
          command = '#ff0000',
          visual = '#ff00ff',
          replace = '#ffff00',
          terminal = '#00ffff',
          delete = '#ff0000',
          copy = '#00ff00',
        },
      })
    end,
  },

  {
    'shaunsingh/nord.nvim',
    config = function()
      require('nord').set()
    end,
  },

  {
    -- Disable indent-blankline
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    opts = {
    }
  },

  -- Git blame plugin 
  {
    'f-person/git-blame.nvim',
    enabled = true,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  -- Better UI
  {
    'stevearc/dressing.nvim',
    enabled = true,
    opts = {
    },
  },

  -- Surround
  {
    'tpope/vim-surround',
    enabled = true,
  },

  {
    'tpope/vim-repeat',
    enabled = true,
  },
  -- Emmet
  {
    'mattn/emmet-vim',
    enabled = true,
  },

  -- confirm quit?
  {
    'yutkat/confirm-quit.nvim',
    event = "cmdlineenter",
    opts = {
      confirm = true,
    },
  },

  -- Git / Diff Viewer
  {
    'sindrets/diffview.nvim',
    enabled = true,
  },

  -- Code Focus
  {
    'folke/twilight.nvim',
    enabled = true,
    opts = {
    }
  },

  {
    'folke/zen-mode.nvim',
    opts = {
      width = 180,
    }
  },

  -- Composer
  {
    'tpope/vim-dispatch',
    enabled = true
  },

  {
    'tpope/vim-projectionist',
    enabled = true
  },

  -- Sessions
  {
    'rmagatti/auto-session',
    enabled = true,
    opts = {
      auto_session_enable_last_session = true,
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = nil,
    },
  },

  {
    'pwntester/nvim-lsp',
    enabled = true
  },

  -- Cosmic
  {
    'CosmicNvim/cosmic-ui',
    enabled = true,
    opts = {
      theme = 'dark',
    },
  },

  -- Configure LazyVim to load morning theme
  {
    "LazyVim/LazyVim",
    opts = {
      --		colorscheme = "evening",
      -- colorscheme = "desert",
      colorscheme = "nord",
      indent = "tabs",
      -- Hide the tab character
      showtabline = 0,
      -- Disable autochdir
      autochdir = false,
    },
  },

  -- Twig
  {
    'othree/html5.vim',
    enabled = true,
  },

  {
    'lumiliet/vim-twig',
    enabled = true,
  },

  -- Multiple Cursors
  {
    'mg979/vim-visual-multi',
    enabled = true,
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    enabled = true,
    opts = {
      use_diagnostic_signs = true 
    },
  },

  -- Highlight word
  {
    'tzachar/local-highlight.nvim',
    enabled = true,
    config = function()
      require('local-highlight').setup()
    end
  },

  -- Focus
  {
    'nvim-focus/focus.nvim',
    enabled = true,
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      {"<leader>/", false},
      -- change a keymap
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      -- Find words in current buffer
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
    },
  },

  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- Tmux
  {
    'derekzyl/termux-nvim',
    lazy = false,
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "php",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
