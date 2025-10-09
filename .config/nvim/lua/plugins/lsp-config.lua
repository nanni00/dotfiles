return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				-- { path = "LazyVim",            words = { "LazyVim" } },
				-- { path = "snacks.nvim",        words = { "Snacks" } },
				{ path = "lazy.nvim" },
			},
		},
	},

	-- Mason package
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},

		config = function()
			require("mason").setup()
		end,
	},

	-- mason-lspconfig -- bridge between mason and nvim-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		opts = {
			-- Specify which server installations should be checked
			ensure_installed = {
				-- Lua
				"lua_ls",
				"stylua",

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

			-- Automatically enable only Lua server
			automatic_enable = {
				-- "lua_ls",
				-- "pylsp",
				"jedi"
			},
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
		config = function()
			vim.lsp.config("lua_ls", {
				settings = {
					["lua_ls"] = {
						cmd = { "lua-language-server" },
						filetypes = { "lua" },
					},
				},
			})

			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						cmd = { "pylsp" },
						filetypes = { "python" },
						plugins = {
							black = {
								enabled = true,
								preview = true,
							},
							pycodestyle = {
								enabled = true,
								maxLineLength = 120,
								maxDocLength = 120,
							},
							pyflake = {
								enabled = false,
							},
							mccabe = {
								enabled = false,
							},
						},
					},
				},
			})

      vim.lsp.enable({"lua_ls", "pylsp"})
		end,

		-- config = function()
		--   -- nvim.cmp lsp helps us to pass some default capabilities
		--   -- to each language server
		--   -- See https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp
		--   local capabilities = require("cmp_nvim_lsp").default_capabilities()
		--
		--   -- For each server we can specify some ad-hoc configurations
		--   vim.lsp.config["lua_ls"] = {
		--     cmd = { "lua-language-server" },
		--     -- a server starts only on this filetypes
		--     filetypes = { "lua" },
		--     capabilities = capabilities,
		--   }
		--
		--   vim.lsp.config["pylsp"] = {
		--     cmd = { "pylsp" },
		--     filetypes = { "python" },
		--     capabilities = capabilities,
		--     plugins = {
		--       black = {
		--         enabled = true,
		--         preview = true
		--       },
		--       pycodestyle = {
		--         enabled = true,
		--         maxLineLength = 88,
		--         maxDocLength = 88
		--       },
		--       pyflakes = {
		--         enabled = false
		--       }
		--     }
		--   }
		--
		--   -- A language server has to be enabled with vim.lsp.enable
		--   -- in our case, we already have the automatic_enable parameter
		--   -- in mason-lspconfig which enables the desired servers
		-- end,
	},
}
