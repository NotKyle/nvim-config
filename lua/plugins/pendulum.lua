return {
  "ptdewey/pendulum-nvim",
  config = function()
    require("pendulum").setup({
      log_file = vim.fn.expand("$HOME/Documents/pendulum.csv"),
      timeout_len = 300,
      timer_len = 60,
      gen_reports = true,
      top_n = 100,
    })
  end,
}
