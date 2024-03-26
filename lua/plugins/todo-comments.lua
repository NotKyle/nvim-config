return {
  "folke/todo-comments.nvim",
  config = function()
    require("todo-comments").setup({
      signs = true,
      keywords = {
        FIX = {
          icon = "",
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" },
        },
        TODO = {
          icon = "",
          color = "info",
          alt = { "NOTE", "INFO" },
        },
        HACK = {
          icon = "",
          color = "warning",
          alt = { "WARN", "WARNING" },
        },
        WARN = {
          icon = "",
          color = "warning",
          alt = { "WARN", "WARNING" },
        },
      },
      highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
      },
      colors = {
        error = { "LspDiagnosticsDefaultError", "ErrorMsg" },
        warning = { "LspDiagnosticsDefaultWarning", "WarningMsg" },
        info = { "LspDiagnosticsDefaultInformation", "MoreMsg" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        pattern = [[\b(KEYWORDS):]],
      },
    })
  end,
}
