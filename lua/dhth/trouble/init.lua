require("trouble").setup {}

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
