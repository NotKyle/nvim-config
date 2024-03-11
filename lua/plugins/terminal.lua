return {
  "rebelot/terminal.nvim",
  config = function()
    require("terminal").setup({
      -- Open terminal in insert mode
      open_insert = false,
      -- Open terminal in a floating window
      floating = true,
      -- Open terminal in a floating window
      floating_opts = {
        border = "single",
        width = 0.8,
        height = 0.8,
        winblend = 3,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      -- Open terminal in a floating window
      hide_numbers = true,
      -- Open terminal in a floating window
      start_in_insert = true,
      -- Open terminal in a floating window
      persist_size = true,
      -- Open terminal in a floating window
      direction = "horizontal",
      -- Open terminal in a floating window
      close_on_exit = true,
      -- Open terminal in a floating window
      shell = vim.o.shell,
      -- Open terminal in a floating window
      keymap = {
        toggle = "<C-t>",
        prev = "<C-h>",
        next = "<C-l>",
      },
    })
  end,
}
