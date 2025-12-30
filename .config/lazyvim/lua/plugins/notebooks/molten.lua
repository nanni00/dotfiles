return {
  {
    "benlubas/molten-nvim",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
      -- add a few new things

      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Init" })
      vim.keymap.set("n", "<localleader>me", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator" })
      vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
      vim.keymap.set("v", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual selection" })
      vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter output" })
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Delete" })
    end,
  },
}
