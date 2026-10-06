-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "quarto", "ipynb", "markdown" },
	callback = function()
		-- We use vim.schedule to ensure the buffer is fully loaded
		-- before running the activation command
		vim.schedule(function()
			if vim.fn.exists(":QuartoActivate") == 2 then
				vim.cmd("QuartoActivate")
			end
		end)
	end,
})

-- For Python, I prefer "self" and "cls" red colored
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python", -- Change this to your language (e.g., "javascript", "rust")
	callback = function()
		-- Set the color for a specific Treesitter group
		-- 'guifg' is the hex color for the text
		vim.api.nvim_set_hl(0, "@lsp.type.selfParameter.python", { fg = "#ff757f" })
		vim.api.nvim_set_hl(0, "@lsp.type.clsParameter.python", { fg = "#ff757f" })

		vim.api.nvim_set_hl(0, "@lsp.mod.readonly.python", { fg = "#ff9e64" })
		vim.api.nvim_set_hl(0, "@lsp.type.namespace.python", { fg = "#e0af68" })
	end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
	pattern = "*.tex",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.breakindent = true
	end,
})
