return {
  "echasnovski/mini.files",
  config = function()
    require("mini.files").setup({
      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },
      windows = {
        preview = true,
        width_preview = 35,
      },
    })
  end,
  version = false,
}
