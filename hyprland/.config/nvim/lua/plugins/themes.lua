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
      style = {
        functions = 'italic',
        methods = 'italic',
        keywords = 'bold,italic',
        types = 'bold',
      },
    }
    require('onedarkpro').load()
    -- [[ Post init configurations ]]
    -- line cursor color
    vim.api.nvim_set_hl(0, 'CursorLineNr', {
      fg = '#ff9e64',
      bold = true,
    })
  end,
}
