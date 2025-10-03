return {
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files (Telescope)"})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep (Telescope)"})
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',

    config = function() 
      require('telescope').setup({
        extension = {
          ["ui-select"] = { 
            require("telescope.themes").get_dropdown {}
          }
        }
      })
      require('telescope').load_extension('ui-select')
    end,
  }
}

