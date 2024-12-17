return {
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
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      provider = "claude",
      auto_suggestions_provider = "claude",
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
