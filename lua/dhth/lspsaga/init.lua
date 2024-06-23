local saga = require 'lspsaga'

saga.setup({})

vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true,noremap = true })
vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })
-- vim.keymap.set("n", "<leader>gg", require("lspsaga.definition").preview_definition, { silent = true,noremap = true })
-- vim.keymap.set("n", "<leader>hh", require("lspsaga.signaturehelp").signature_help, { silent = true })

-- vim.keymap.set("n", "[d", require("lspsaga.diagnostic").goto_prev, { silent = true, noremap =true })
-- vim.keymap.set("n", "]d", require("lspsaga.diagnostic").goto_next, { silent = true, noremap =true })

