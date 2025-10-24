return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      -- Specify which server installations should be checked
      ensure_installed = {
        -- Python
        --
        -- I have installed both ruff and pylsp
        -- ruff should be a substitute for many sub-packages of pylsp,
        -- in particular for linting and formatting, but I need also
        -- (static) type-checking, and mypy configuration with none-ls
        -- isn't really smooth. With pylsp this should be simpler...
        -- "ruff",
        -- "pylsp",
      },

      -- The above servers will be automatically installed
      -- through Mason if not found on this machine
      auto_install = true,

      -- Automatically enable
      -- NOTE: there seems to be some issue in current version of
      -- mason/mason-lspconfig/lspconfig/neovim, because with this
      -- one enabled, no longer the setup is done properly for servers,
      -- e.g. for pylsp the command :PyLspInstall isn't created and
      -- configurations are not loaded correctly
      automatic_enable = false,
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          keys = {
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },

        ty = {
          settings = {
            ty = {
              experimental = {
                autoImport = true,
              },
            },
          },
        },
      },
      setup = {
        ruff = function()
          LazyVim.lsp.on_attach(function(client, _)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end, "ruff")
        end,
        ty = function()
          LazyVim.lsp.on_attach(function(client, _)
            client.server_capabilities.hoverProvider = true
          end, "ty")
        end,
      },
    },
    --   opts = {
    --     filetype = { "python" },
    --     servers = {
    --       pylsp = {
    --         settings = {
    --           pylsp = {
    --             plugins = {
    --               pycodestyle = { enabled = false },
    --               mccabe = { enabled = false },
    --               pyflakes = { enabled = false },
    --               ruff = {
    --                 enabled = true,
    --                 formatEnabled = true,
    --                 format = { "I" },
    --                 severities = {
    --                   ["F401"] = "W",
    --                 },
    --
    --                 lineLength = 100,
    --               },
    --
    --               jedi_hover = {
    --                 enabled = true,
    --               },
    --
    --               jedi_completion = {
    --                 enabled = true,
    --
    --                 -- gives fuzzy completion while writing
    --                 fuzzy = true,
    --                 eager = true,
    --               },
    --
    --               -- rope_autoimport = { enabled = false },
    --               -- rope_completion = { enabled = false },
    --               --
    --               -- mypy = {
    --               --   enabled = false,
    --               -- },
    --               --
    --               -- pylsp_mypy = {
    --               --   enabled = false,
    --               --   follow_imports = "silent",
    --               -- },
    --             },
    --           },
    --         },
    --       },
    --     },
    --     -- setup = {
    --     --   ruff = function()
    --     --     LazyVim.lsp.on_attach(function(client, _)
    --     --       client.server_capabilities.hoverProvider = false
    --     --     end, ruff)
    --     --   end,
    --     -- },
    --   },
    --
    --   -- config = function()
    --   --   vim.lsp.enable("pylsp", true)
    --   -- end,
  },
}
