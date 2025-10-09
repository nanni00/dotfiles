return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself

	config = function()
		require("neo-tree").setup({
			filesystem = {
				window = {
					mappings = {
						["o"] = "system_open",
            ["<leader>"] = "which_key",
					},
				},
			},

			commands = {
        which_key = function (_)
          require("which-key").show()
        end,
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					-- macOs: open file in default application in the background.
					vim.fn.jobstart({ "open", path }, { detach = true })
					-- Linux: open file in default application
					vim.fn.jobstart({ "xdg-open", path }, { detach = true })

					-- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
					local p
					local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
					if lastSlashIndex then
						p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
					else
						p = path -- If no slash found, return original path
					end
					vim.cmd("silent !start explorer " .. p)
				end,
			},
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "󰌵",
				},
			},
		})

		vim.keymap.set("n", "<C-n>", "<CMD>Neotree toggle reveal left<CR>", { desc = "Open filesystem" })
	end,
}
