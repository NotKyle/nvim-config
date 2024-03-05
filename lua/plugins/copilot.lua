return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  config = function()
    vim.keymap.set("i", "<Tab>", function()
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
      end
    end, { desc = "Super Tab" })
    require("copilot").setup({
      filetypes = {
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        lua = true,
        python = true,
        rust = true,
        go = true,
        c = true,
        cpp = true,
        java = true,
        typst = true,
        markdown = true,
        sh = true,
        yaml = true,
        txt = true,
        php = true,
        json = true,
        toml = true,
        html = true,
        css = true,
        scss = true,
        less = true,
        graphql = true,
        graphqls = true,
        sql = true,
        vim = true,
        viml = true,
      },
      panel = {
        auto_refresh = true,
        keymap = {
          open = "<C-s>",
        },
        layout = {
          position = "bottom",
          ratio = 0.3,
        },
      },
      suggestion = {
        auto_trigger = true,
        debounce = 20,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = "<Down>",
          prev = "<Up>",
        },
      },
      server_opts_overrides = {
        settings = {
          advanced = {
            listCount = 10,
            inlineSuggestCount = 10,
          },
        },
      },
    })
  end,
  -- opts = {},
  -- keys = {
  --   { "<Tab>", function()
  --     vim.notify("accepting suggestion")
  --     if require("copilot.suggestion").is_visible() then
  --       require("copilot.suggestion").accept()
  --     else
  --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  --     end
  --   end, { desc = "Copilot super tab", mode = { "i", "v" } }
  --   }
  -- }
}
