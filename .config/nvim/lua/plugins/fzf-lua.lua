return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "nvim-mini/mini.icons" },
	opts = {},

	config = function()
		-- require("fzf-lua").setup({"fzf-native"})
		local map = vim.keymap.set
		local fzf = require("fzf-lua")
		map({ "n", "v", "i" }, "<C-p>", fzf.files, { desc = "Find files" })
		map({ "n", "v" }, "<C-\\>", fzf.buffers, { desc = "Find buffers" })
		map({ "n", "v", "i" }, "<C-g>", fzf.grep, { desc = "Grep (fzf)" })
		map({ "n", "v", "i" }, "<C-l>", fzf.live_grep, { desc = "Live grep (fzf)" })
		map({ "n", "v", "i" }, "<C-k>", fzf.builtin, { desc = "Builtin commands (fzf)" })
		map({ "n", "v" }, "<leader>gs", fzf.git_status, { desc = "Git status (fzf)" })
		map({ "n", "v" }, "<leader>ca", fzf.lsp_code_actions, { desc = "Code actions (fzf)" })


    fzf.register_ui_select()   
    fzf.setup({
      lsp = {
        code_actions = {
          previewer = "codeaction_native",
          previewer_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS"
        }
      }
    })

		-- vim.keymap.set({ "n", "v" }, "<C-p>", function()
		-- 	require("fzf-lua").files()
		-- end, { desc = "Find file" })
	end,
}
