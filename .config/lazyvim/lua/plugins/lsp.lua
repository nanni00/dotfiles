return {
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
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
          Snacks.util.lsp.on({ name = "ruff" }, function(_, client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
        ty = function()
          Snacks.util.lsp.on({ name = "ty" }, function(_, client)
            client.server_capabilities.hoverProvider = true
          end)
        end,
      },
    },
  },
}
