return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"ibhagwan/fzf-lua",
		},

		-- by typing <leader>v it seems that no command is available
		-- if we are not on a python file or this has not typed yet
		ft = "python", -- Load when opening Python files
		keys = {
			{ "<leader>cvs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" }, -- Open picker on keymap
		},

		opts = { -- this can be an empty lua table - just showing below for clarity.
			search = {
				poetry = false,
				pyenv = false,
				anaconda = false,

				custom_project_venvs_search = {
					command = 'fd -HI "python3..." ~/projects | grep ".venv/bin"',
					-- command = "fd '.venv/bin/python$' ~/projects",
				},
			}, -- if you add your own searches, they go here.
			options = {
				debug = true,
				search_timeout = 8,
				picker = "snacks",
			},
		},

		config = function(_, opts)
			require("venv-selector").setup(opts)
		end,
	},
}
