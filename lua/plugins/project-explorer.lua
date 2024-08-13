return {
  "Rics-Dev/project-explorer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    paths = {
      "~/Desktop/Sites/",
      "~/.config/nvim",
    },
    file_explorer = function(dir)
      vim.cmd("Telescope file_browser")
      vim.cmd("cd " .. dir)
    end,
  },
  config = function(_, opts)
    require("project_explorer").setup(opts)
  end,

  keys = {
    { "<leader>pp", "<cmd>ProjectExplorer<CR>", desc = "Open Project Explorer" },
  },
  lazy = false,
}
