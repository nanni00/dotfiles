return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "ibhagwan/fzf-lua",
  },

  -- by typing <leader>v it seems that no command is available
  -- if we are not on a python file or this has not typed yet
  ft = "python", -- Load when opening Python files
  keys = {
    { "<leader>cvs", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
  },
  opts = { -- this can be an empty lua table - just showing below for clarity.
    search = {}, -- if you add your own searches, they go here.
    options = {
      search_timeout = 8,
    }, -- if you add plugin options, they go here.
  },

  config = function(_, opts)
    require("venv-selector").setup(opts)
  end,
}
