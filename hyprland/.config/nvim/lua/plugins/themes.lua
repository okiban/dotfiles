return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme = 'onedarkpro'
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    require('onedarkpro.config').set_theme 'onedark_dark'
    require('onedarkpro').setup {
      highlights = {
        CursorLineNr = { fg = '#ff9e64', bg = '#2C313C', bold = true },
        CursorLine = { bg = '#2C313C' },
        YankHighlight = { bg = '#ADD8E6', fg = '#0000FF' },
      },
      style = {
        functions = 'italic',
        methods = 'italic',
        keywords = 'bold,italic',
        types = 'bold',
      },
    }
    require('onedarkpro').load()
  end,
}
