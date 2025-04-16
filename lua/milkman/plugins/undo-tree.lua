return {
  'mbbill/undotree',
  version = '*',
  config = function()
    vim.g.undotree_DiffCommand = 'FC'
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndo Tree' })
  end,
}
