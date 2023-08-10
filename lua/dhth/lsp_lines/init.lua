require("lsp_lines").setup()

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { only_current_line = false },
})

vim.keymap.set(
  "",
  "<leader>ls",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
 signs = false
}
)

