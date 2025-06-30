-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic [Q]uickfix list',
})

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
  desc = 'Exit terminal mode',
})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', {
  desc = 'Move focus to the left window',
})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', {
  desc = 'Move focus to the right window',
})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', {
  desc = 'Move focus to the lower window',
})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', {
  desc = 'Move focus to the upper window',
})

--
-- Mappings fzf
--
vim.keymap.set('n', '<leader><leader>', function()
  require('fzf-lua').files()
end, { desc = 'Search for files' })

vim.keymap.set('n', '<leader><C-l>', function()
  require('fzf-lua').live_grep()
end, { desc = 'Search in files' })

---
--- Customs
---
vim.keymap.set('n', '<C-Backspace>', 'db') -- the good old ctrl backspace to get ride of a word
vim.keymap.set('i', '<C-Backspace>', '<Esc>dbi') -- the good old ctrl backspace to get ride of a word
