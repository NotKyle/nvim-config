-- lua/plugins/coding.lua
return {
  -- Adding PHPActor as a language server
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.phpactor.setup({
        on_attach = function(client, bufnr)
          -- Custom key bindings for LSP functionality
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })
    end,
  },

  -- LSPSaga for enhanced LSP UI
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        code_action_lightbulb = {
          enable = true,
          enable_in_insert = false,
        },
        finder = {
          max_height = 0.5,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- Null-ls with formatting only (no diagnostics for PHPActor)
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.phpcsfixer.with({
            extra_args = { "--config=.php-cs-fixer.dist.php" },
          }),
        },
        on_attach = function(client) end,
      })
    end,
  },

  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_last_session = true,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "andymass/vim-matchup",
    config = function()
      vim.api.nvim_set_hl(0, "OffScreenPopup", { fg = "#fe8019", bg = "#3c3836", italic = true })
      vim.g.matchup_matchparen_offscreen = {
        method = "popup",
        highlight = "OffScreenPopup",
      }
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "Rics-Dev/project-explorer.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      paths = {
        "~/Desktop/Sites/",
        "~/.config/nvim",
      },
      file_explorer = function(dir)
        vim.cmd("Telescope file_browser")
        vim.cmd("cd " .. dir)
      end,
    },
    config = function(_, opts)
      require("project_explorer").setup(opts)
    end,

    keys = {
      { "<leader>pp", "<cmd>ProjectExplorer<CR>", desc = "Open Project Explorer" },
    },
    lazy = false,
  },
  {
    "coffebar/neovim-project",
    dependencies = {
      { "Shatur/neovim-session-manager" },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup()
    end,
  },

  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

  { "numToStr/Comment.nvim", opts = {} },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = false,
          char = "│",
          show_start = false,
          show_end = false,
          include = {
            node_type = { ["*"] = { "*" } },
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│",
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Disable indentscope for certain filetypes",
        pattern = {
          "NvimTree",
          "help",
          "Trouble",
          "trouble",
          "lazy",
          "notify",
          "better_term",
          "toggleterm",
          "lazyterm",
          "noice",
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- helper keymaps to move forward and backward using [key ]key
  {
    "echasnovski/mini.bracketed",
    version = false,
    opts = {},
  },

  {
    "github/copilot.vim",
    config = function()
      -- Disable copilot suggestions
      vim.g.copilot_filetypes = {
        -- ['*'] = false,
      }

      vim.keymap.set("i", "<Right>", 'copilot#Accept("\\<Right>")', {
        expr = true,
        replace_keycodes = false,
        silent = true, -- Disable echo in command line
      })

      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<Tab>", "<Tab>")

      vim.g.disable_copilot = false

      vim.api.nvim_create_user_command("ToggleCopilot", function()
        vim.g.disable_copilot = not vim.g.disable_copilot
        if not vim.g.disable_copilot then
          vim.cmd("Copilot enable")
        else
          vim.cmd("Copilot disable")
        end
        vim.notify("Copilot: " .. (vim.g.disable_copilot and "Disabled" or "Enabled"))
      end, {
        desc = "Toggle Copilot",
      })

      vim.keymap.set("n", "<leader>tc", "<ESC><cmd>ToggleCopilot<CR>", { desc = "[T]oggle [C]opilot" })
    end,
  },

  {
    "metakirby5/codi.vim",
  },

  {
    "tpope/vim-abolish",
    config = function()
      vim.g.abolish_case = "smart"
    end,
  },

  { -- lazy
    "ccaglak/phptools.nvim",
    keys = {
      { "<leader>lm", "<cmd>PhpMethod<cr>" },
      { "<leader>lc", "<cmd>PhpClass<cr>" },
      { "<leader>ls", "<cmd>PhpScripts<cr>" },
      { "<leader>ln", "<cmd>PhpNamespace<cr>" },
      { "<leader>lg", "<cmd>PhpGetSet<cr>" },
      { "<leader>lf", "<cmd>PhpCreate<cr>" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("phptools").setup({
        ui = false, -- if you have stevearc/dressing.nvim or something similar keep it false or else true
      })
      vim.keymap.set("v", "<leader>lr", ":PhpRefactor<cr>")
    end,
  },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any opts here
  --   },
  --   dependencies = {
  --     "echasnovski/mini.icons",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below is optional, make sure to setup it properly if you have lazy=true
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}
