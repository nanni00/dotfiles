-- nvim editing & others options

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
		-- Only show virtual text for errors and warnings (optional)
		-- severity = { min = vim.diagnostic.severity.WARN },
	},
	signs = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})
