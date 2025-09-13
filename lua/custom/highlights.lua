vim.cmd [[highlight DefinitionHighlight guibg=#fabd2f guifg=#282828]]
vim.cmd [[highlight SignColumn guibg=#282828]]
vim.cmd [[highlight CursorLineNr guibg=#282828]]
-- vim.cmd [[highlight StatusLine guibg=#a89984]]

-- vim.cmd [[highlight CursorLine guibg=#282828]]
-- vim.cmd [[highlight CursorLineNr guibg=#282828]]
-- vim.cmd [[highlight LineNrAbove guifg=#a89984]]
-- vim.cmd [[highlight LineNrBelow guifg=#a89984]]
-- vim.cmd [[highlight SignColumn guibg=#1b1b1b]]
--
-- vim.cmd [[highlight StatusBar guibg=#1b1b1b]]
-- vim.cmd [[highlight TabLineFill guibg=#1b1b1b]]
-- vim.cmd [[highlight TabLine guibg=#1b1b1b guifg=#a89984]]
-- vim.cmd [[highlight TabLineSel guibg=#1b1b1b guifg=#fabd2f]]
-- vim.cmd [[highlight StatusLine guibg=#a89984 guifg=#282828]]


-- go template and helm
vim.filetype.add({
    extension = {
        gotmpl = 'gotmpl',
    },
    pattern = {
        [".*/templates/.*%.tpl"] = "helm",
        [".*/templates/.*%.ya?ml"] = "helm",
        ["helmfile.*%.ya?ml"] = "helm",
    },
})
