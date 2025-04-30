-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal right<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['R'] = 'easy',
        },
      },
      commands = {
        ['easy'] = function(state)
          local node = state.tree:get_node()
          local path = node.type == 'directory' and node.path or vim.fs.dirname(node.path)
          require('easy-dotnet').create_new_item(path, function()
            require('neo-tree.sources.manager').refresh(state.name)
          end)
        end,
      },
    },
  },
}
