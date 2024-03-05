return {
  "mvllow/modes.nvim",
  enabled = true,
  config = function()
    require("modes").setup({
      colors = {
        insert = "#00ff00",
        normal = "#0000ff",
        command = "#ff0000",
        visual = "#ff00ff",
        replace = "#ffff00",
        terminal = "#00ffff",
        delete = "#ff0000",
        copy = "#00ff00",
      },
    })
  end,
}
