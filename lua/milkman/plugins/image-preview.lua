return {
  '3rd/image.nvim',
  build = false,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    backend = 'sixel',
    processor = 'magick_cli',
    window_overlap_clear_enabled = true,
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'markdown', 'vimwiki' },
      },
    },
    max_height_window_percentage = 50,
    tmux_show_only_in_active_window = true,
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
  },
}
