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
        "ruff",
        "pylsp",
      },

      -- The above servers will be automatically installed
      -- through Mason if not found on this machine
      auto_install = true,

      -- Automatically enable
      automatic_enable = true,
    },
  },

  {
    -- This package allows to install those packages available in Mason
    -- registry that are not recognized as LSP servers from nvim-lspconfig,
    -- like black, isort and mypy (for Python)
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- "mypy",
        "black",
        "isort",
      },

      auto_install = true,
      auto_update = true,
      run_on_start = true,

      integrations = {
        ["mason-lspconfig"] = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          capabilities = {
            offsetEncoding = { "utf-8" },
            positionEncoding = { "utf-8" },
          },

          settings = {
            pylsp = {
              plugins = {
                black = {
                  enabled = true,
                },
                pycodestyle = {
                  enabled = true,
                  maxLineLength = 100,
                  maxDocLength = 100,
                },
                mccabe = {
                  enabled = false,
                },
                pyflakes = {
                  enabled = false,
                },
              },
            },
          },
        },

        -- setup = {
        --   [pylsp] = function()
        --     LazyVim.lsp.on_attach(function(client, _)
        --       if client.name == "pylsp" then
        --         client.server_capabilities.positionEncoding = "utf-8"
        --       end
        --     end, "pylsp")
        --   end,
        -- },
      },
    },
  },
}
