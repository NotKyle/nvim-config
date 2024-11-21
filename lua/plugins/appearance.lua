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
    "folke/twilight.nvim",
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "tzachar/highlight-undo.nvim",
    opts = {},
  },
}
