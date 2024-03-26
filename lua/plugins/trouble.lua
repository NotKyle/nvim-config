return {
  "folke/trouble.nvim",
  enabled = true,
  opts = {
    use_diagnostic_signs = true,
  },
  setup = function()
    local map = require("utils").map
    map("n", "<leader>xx", "<cmd>Trouble<cr>")
    map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>")
    map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>")
    map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
    map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
    map("n", "gR", "<cmd>Trouble lsp_references<cr>")
  end,
}
