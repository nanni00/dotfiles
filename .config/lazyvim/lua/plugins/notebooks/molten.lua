return {
	{
		"benlubas/molten-nvim",
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_auto_open_output = true
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_wrap_output = true
			vim.g.molten_output_virt_lines = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = false
			vim.g.molten_enter_output_behavior = "open_and_enter"

			-- vim.g.molten_auto_open_output = true
			-- vim.g.molten_image_provider = "image.nvim"
			-- vim.g.molten_wrap_output = true
			-- vim.g.molten_output_virt_lines = true
			-- vim.g.molten_virt_text_output = true
			-- vim.g.molten_virt_lines_off_by_1 = true
			-- vim.g.molten_enter_output_behavior = "open_and_enter"
			-- vim.g.molten_use_border_highlights = true

			-- add a few new things

			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Init" })
			vim.keymap.set("n", "<localleader>mD", ":MoltenDeinit<CR>", { desc = "De-Init" })
			vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate Line" })
			vim.keymap.set("n", "<localleader>me", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator" })
			vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
			vim.keymap.set(
				"v",
				"<localleader>mv",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ desc = "Evaluate visual selection" }
			)
			vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>", { desc = "Enter output" })
			vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
			vim.keymap.set("n", "<localleader>mk", ":MoltenInterrupt<CR>", { desc = "Interrupt the kernel" })
			vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Delete" })

			-- automatically import output chunks from a jupyter notebook
			-- tries to find a kernel that matches the kernel in the jupyter notebook
			-- falls back to a kernel that matches the name of the active venv (if any)
			--   local imb = function(e) -- init molten buffer
			--     vim.schedule(function()
			--       local kernels = vim.fn.MoltenAvailableKernels()
			--       local try_kernel_name = function()
			--         local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
			--         return metadata.kernelspec.name
			--       end
			--       local ok, kernel_name = pcall(try_kernel_name)
			--       if not ok or not vim.tbl_contains(kernels, kernel_name) then
			--         kernel_name = nil
			--         local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
			--         if venv ~= nil then
			--           kernel_name = string.match(venv, "/.+/(.+)")
			--         end
			--       end
			--       if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
			--         vim.cmd(("MoltenInit %s"):format(kernel_name))
			--       end
			--       vim.cmd("MoltenImportOutput")
			--     end)
			--   end
			--
			--   -- automatically import output chunks from a jupyter notebook
			--   vim.api.nvim_create_autocmd("BufAdd", {
			--     pattern = { "*.ipynb" },
			--     callback = imb,
			--   })
			--
			--   -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
			--   vim.api.nvim_create_autocmd("BufEnter", {
			--     pattern = { "*.ipynb" },
			--     callback = function(e)
			--       if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
			--         imb(e)
			--       end
			--     end,
			--   })
			--
			--   -- automatically export output chunks to a jupyter notebook on write
			--   vim.api.nvim_create_autocmd("BufWritePost", {
			--     pattern = { "*.ipynb" },
			--     callback = function()
			--       if require("molten.status").initialized() == "Molten" then
			--         vim.cmd("MoltenExportOutput!")
			--       end
			--     end,
			--   })
		end,
	},
}
