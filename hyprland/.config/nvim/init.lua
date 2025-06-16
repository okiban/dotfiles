-- [[ Global vim configurations (to be loaded BEFORE lazy)  ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ lazy-bootstrap ]]
require 'lazy-bootstrap'

-- [[ plugins ]]
require 'lazy-plugins'

-- [[ Post init configurations ]]
-- line cursor color
vim.api.nvim_set_hl(0, 'CursorLineNr', {
  fg = '#ff9e64',
  bold = true,
})
