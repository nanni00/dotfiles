-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- this should be in someway global
-- <CR> means Carriage-Return, and in this way the command is launched
-- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeOpen<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-n>", function()
  require("snacks").explorer.open()
  --require("nvim-tree.api").tree.toggle()
end, { noremap = true, silent = true })


-- set the keymap for vim-doge
vim.keymap.set('n', '<Leader>cd', '<Plug>(doge-generate)')
