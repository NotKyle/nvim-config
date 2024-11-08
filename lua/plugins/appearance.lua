-- lua/plugins/appearance.lua

-- Custom LSP progress handler for PHPActor
local phpactor_token = nil

vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local value = result.value
  if not value.kind then
    return
  end

  local client_id = ctx.client_id
  local name = vim.lsp.get_client_by_id(client_id).name

  -- Check if the LSP client is PHPActor
  if name == "phpactor" then
    -- Filter out recurring notifications for the same token
    if result.token == phpactor_token then
      return
    end

    -- Filter out "Resolving code actions" notifications
    if value.title == "Resolving code actions" then
      phpactor_token = result.token
      return
    end
  end

  -- Show notifications for other cases
  vim.notify(value.message or "", "info", {
    title = value.title,
  })
end

return {
  {
    "xiyaowong/transparent.nvim",
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin-frappe")
    end,
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "folke/twilight.nvim",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },

    config = function()
      require("noice").setup({
        routes = {
          -- Hide 'written' messages
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },

          -- Disable PHPCS missing messages
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "phpcs",
            },
            opts = { skip = true },
          },
        },
        lsp = {
          -- Disable Noice's LSP progress handler
          progress = { enabled = false },
        },
      })
    end,
  },
  {
    "ramojus/mellifluous.nvim",
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "tzachar/highlight-undo.nvim",
    opts = {},
  },
  -- {
  --   "OXY2DEV/bars-N-lines.nvim",
  --   -- No point in lazy loading this
  --   lazy = false,
  -- },

  -- NvChad stuff
  { "nvchad/minty", lazy = true },
  { "nvchad/volt", lazy = true },
  { "nvchad/menu", lazy = true },
}
