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

			opts.sources = vim.list_extend(opts.sources or {}, {
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.stylua,

						-- none-ls extras use require() https://github.com/nvimtools/none-ls-extras.nvim#setup
						-- require("none-ls.diagnostics.ruff"),
						-- null_ls.builtins.formatting.isort,
						-- null_ls.builtins.formatting.black,
						--
						-- null_ls.builtins.diagnostics.mypy,
					},
				}),
			})

			vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })
		end,
	},
}
