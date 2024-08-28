-- lua/plugins/coding.lua
return {
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
  {
    { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
    },

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
    { "echasnovski/mini.bracketed", version = false, opts = {} },
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
}
