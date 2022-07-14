require("trouble").setup {}

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
