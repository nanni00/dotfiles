return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  },

  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },

    config = function(_, opts)
      local null_ls = require("null-ls")

      -- define the root directory
      opts.root_dir = opts.root_dir or require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git")

      -- extend the default list of sources
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- Lua
        null_ls.builtins.formatting.stylua,

        -- Python

        -- none-ls extras use require() https://github.com/nvimtools/none-ls-extras.nvim#setup
        -- require("none-ls.formatting.ruff"),
        -- require("none-ls.diagnostics.ruff"),
        --
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.formatting.black,
        -- null_ls.builtins.diagnostics.mypy,
      })

      null_ls.setup(opts)

      vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
      -- by using noice-nvim, this is no longer necessary (if this is disabled, hover support
      -- provided by noice is unstable, error occurs when no information is available and also
      -- borders are not displayed properly)
      -- See https://github.com/neovim/neovim/discussions/27434#discussioncomment-8615500
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.definition, { desc = "Go to reference" })
     end,
  },
}
