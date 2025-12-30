return {
  {
    "nvimtools/hydra.nvim",
    dependencies = "anuvyklack/keymap-layer.nvim",
  },

  {
    -- "GCBallesteros/jupytext.nvim",
    "SteveDala/jupytext.nvim",
    branch = "fix-deprecated-health",
    event = { "BufReadPre *.ipynb", "BufNewFile *.ipynb" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = false,
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
        custom_language_formatting = {
          python = {
            extension = "md",
            style = "markdown",
            force_ft = "markdown",
          },
        },
      })
    end,
  },

  { "jmbuhr/otter.nvim", ft = { "markdown", "quarto" } },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "nvim-lspconfig",
      "hydra.nvim",
      "otter.nvim",
    },
    ft = { "quarto", "markdown", "norg" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python", "rust", "lua" },
          chunks = "all", -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          hover = "H",
          definition = "gd",
          rename = "<leader>rn",
          references = "gr",
          format = "<leader>gf",
        },
        codeRunner = {
          enabled = true,
          ft_runners = {
            bash = "slime",
          },
          default_method = "molten",
        },
      })

      vim.keymap.set(
        "n",
        "<localleader>qp",
        quarto.quartoPreview,
        { desc = "Preview the Quarto document", silent = true, noremap = true }
      )

      -- to create a cell in insert mode, I have the ` snippet
      vim.keymap.set(
        "n",
        "<localleader>cc",
        "i`<Tab>",
        -- the remap=true is required since this allows to recursively call also the
        -- actual snippet, otherwise the keymap-Tab is treated as a common string
        { desc = "Create a new code cell", silent = true, remap = true }
      )

      vim.keymap.set(
        "n",
        "<localleader>cs",
        "i```\r\r```{}<left>",
        { desc = "Split code cell", silent = true, noremap = true }
      )

      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })

      -- for more keybinds that I would use in a quarto document, see the configuration for molten
      -- require("plugins.hydra.notebook")
    end,
  },
}
