-- Simple and nice spot from https://www.mitchellhanberg.com/modern-format-on-save-in-neovim
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format({ async = true, id = args.data.client_id })
			end,
		})
	end,
})
