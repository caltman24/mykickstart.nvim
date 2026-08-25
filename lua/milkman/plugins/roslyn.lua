return {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  opts = {
    broad_search = true, -- useful if your sln/project layout is weird
  },
  dependencies = {
    'mason-org/mason.nvim',
  },
}
