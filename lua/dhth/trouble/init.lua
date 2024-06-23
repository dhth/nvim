require("trouble").setup {}

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("n", "<leader>dg", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
