return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      -- Your existing options:
      size = 60,
      open_mapping = [[<c-\>]], -- Toggles the last used/default terminal
      direction = 'vertical',
      -- float_opts = {
      --   border = 'curved',
      --   title_pos = 'left',
      -- },
      -- Optional: Close the terminal buffer when the process exits
      -- close_on_exit = true,
      -- Optional: Persist terminal state (requires session management)
      -- persist_size = true,
      -- persist_mode = true, -- Note: persist_mode might interfere with switching
    }

    -- Keymap for :TermSelect command (using Alt+\ as an example)
    -- You can change <A-\> to something else if you prefer
    vim.keymap.set({ 'n', 't' }, '<A-\\>', function()
      -- Use the Lua function equivalent of :TermSelect
      vim.cmd 'TermSelect'
    end, { noremap = true, silent = true, desc = 'Select ToggleTerm' })

    -- Your custom TermNew command is no longer strictly necessary
    -- as toggling by ID (e.g., <c-\>1) will create the terminal if needed.
    -- You can remove it or keep it if you have a specific use case for it.
    vim.api.nvim_create_user_command('TermNew', function()
      local term = require('toggleterm.terminal').Terminal:new {}
      term:spawn()
      term:toggle()
    end, { bang = true })
  end,
}
