BUF_NOREMAP_SILENT('i', 'Í', '<space>=><space>')
BUF_NOREMAP_SILENT('n', 'Í', 'a<space>=><space>')
BUF_NOREMAP_SILENT('i', 'Å', '<space><-<space>')
BUF_NOREMAP_SILENT('n', 'Å', 'a<space><-<space>')
BUF_NOREMAP_SILENT('n', '<leader>rm', ':lua require("custom.helpers.code.general").scala_run(true)<CR>')
BUF_NOREMAP_SILENT('i', '..', '<space>=><space>')
BUF_NOREMAP_SILENT('i', ',,', '<space><-<space>')
BUF_NOREMAP_FUNC_SILENT('n', '<leader>bb',
    function()
        vim.cmd [[MetalsImportBuild]]
        print("importing build...")
    end
)
BUF_NOREMAP_SILENT('n', '==', ':lua require("custom.helpers.code.scala").writeBoilerplateWithMain()<CR>')
