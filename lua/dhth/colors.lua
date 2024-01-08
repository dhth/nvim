-- SECTIONBACKGROUNDSTART

vim.o.background = "dark"

-- SECTIONBACKGROUNDEND

require "dhth.colorschemes.gruvbox_nvim"

vim.api.nvim_exec([[
  hi DiffAdd      gui=none    guifg=#1F2F38          guibg=#84B97C
  hi DiffChange   gui=none    guifg=none             guibg=none
  hi DiffDelete   gui=bold    guifg=#1F2F38          guibg=#DC657D
  hi DiffText     gui=bold    guifg=#1F2F38          guibg=#D4B261
]], false)
