return {
  "rachartier/tiny-code-action.nvim",
  event = "LspAttach",
  config = function()
    require("tiny-code-action").setup()
  end,
}
