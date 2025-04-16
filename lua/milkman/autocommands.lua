-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set colorcolumn at 120 for C# files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs',
  callback = function()
    vim.opt_local.colorcolumn = '120'
  end,
})

-- Set colorcolumn at 100 for tsx files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascriptreact',
  callback = function()
    vim.opt_local.colorcolumn = '100'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typescriptreact',
  callback = function()
    vim.opt_local.colorcolumn = '100'
  end,
})
