return {
  'Hoffs/omnisharp-extended-lsp.nvim',
  version = '*',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    vim.keymap.set('n', 'gr', function()
      require('omnisharp_extended').telescope_lsp_references(require('telescope.themes').get_ivy { excludeDefinition = true })
    end, { noremap = true })
    vim.keymap.set('n', 'gd', require('omnisharp_extended').telescope_lsp_definition, { noremap = true })
    vim.keymap.set('n', '<leader>D', function()
      require('omnisharp_extended').telescope_lsp_references()
    end, { noremap = true })
    vim.keymap.set('n', 'gi', require('omnisharp_extended').telescope_lsp_implementation, { noremap = true })
  end,
}
