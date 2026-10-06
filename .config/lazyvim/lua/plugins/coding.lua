return {
	"nvim-mini/mini.pairs",
	event = "VeryLazy",
	opts = {
		mappings = {
			["$"] = { action = "closeopen", pair = "$$", neigh_pattern = "^[^\\]", register = { cr = false } },
		},
	},
	config = function(_, opts)
		LazyVim.mini.pairs(opts)
	end,
}
