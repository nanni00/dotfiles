return {
	"uhs-robert/sshfs.nvim",
	opts = {
		connections = {
			sshfs_args = {
				"-o follow_symlinks",
			},
		},

		hooks = {
			on_mount = {
				auto_change_to_dir = true,
				auto_run = "none",
			},
		},

		host_paths = {
			["sparc20"] = {
				"~/projects/orqa",
				"~/projects/Blend",
				"~/projects/ULOD",
				"~/projects/hnsw-jaccard",
				"~/projects/correlation-research",
			},
			["lggpu"] = {
				"~/projects/orqa",
				"~/projects/ULOD",
				"~/projects/hnsw-jaccard",
				"~/projects/Blend",
			},
		},
	},
}
