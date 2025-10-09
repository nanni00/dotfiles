-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Snacks explorer
vim.keymap.set({ "n", "v" }, "<C-n>", function()
  require("snacks.explorer").open({ hidden = true, ignored = false })
end, { desc = "Explorer Snacks (hiddent-ignored)" })

vim.keymap.set({ "n", "v" }, "<C-p>", function()
  require("snacks.picker").files({ hidden = true, ignored = false })
end, { desc = "Search file" })
