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
		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "stylua" },
				auto_install = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config["lua_ls"] = {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							global = { "vim" },
						},
					},
				},
			}

			vim.lsp.enable("lua_ls")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.definition, { desc = "Go to reference" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
		end,
	},
}
