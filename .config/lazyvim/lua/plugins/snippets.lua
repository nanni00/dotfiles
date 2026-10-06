return {
	{
		"L3MON4D3/LuaSnip",
		-- -- follow latest release.
		-- version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- -- install jsregexp (optional!).
		-- build = "make install_jsregexp",

		opts = function()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/lazyvim/lua/snippets" })

			local ls = require("luasnip")

			-- vim.keymap.set({ "i" }, "<Tab>", function()
			--   ls.expand()
			-- end, { silent = true })
			-- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			--   ls.jump(1)
			-- end, { silent = true })
			-- -- vim.keymap.set({ "i", "s" }, "<C-J>", function()
			-- --   ls.jump(-1)
			-- -- end, { silent = true })
			--
			-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
			--   if ls.choice_active() then
			--     ls.change_choice(1)
			--   end
			-- end, { silent = true })
		end,
	},

	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"lervag/vimtex",
		},
		config = function()
			require("luasnip-latex-snippets").setup()
			-- or setup({ use_treesitter = true })
			require("luasnip").config.setup({ enable_autosnippets = true })
		end,
	},
}
