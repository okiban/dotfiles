return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true,
      formats = {
        'png',
        'jpg',
        'jpeg',
        'gif',
        'bmp',
        'webp',
        'tiff',
        'heic',
        'avif',
        'mp4',
        'mov',
        'avi',
        'mkv',
        'webm',
        'pdf',
      },
    },
  },
}
