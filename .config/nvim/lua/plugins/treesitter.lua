return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  lazy = false,
  -- event = { "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },

  config = function()
    -- treesitter will be configured only for these filetype
    require("nvim-treesitter").install({ "lua", "python" })

    -- Configure the treesitter parser on python files
    -- the start() api function actuvates this functionality
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
