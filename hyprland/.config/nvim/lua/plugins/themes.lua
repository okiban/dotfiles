return {
  'olimorris/onedarkpro.nvim',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme = 'onedarkpro'
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    require('onedarkpro.config').set_theme 'onedark_dark'
    require('onedarkpro').load()
  end,
}
