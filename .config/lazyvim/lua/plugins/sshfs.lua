return {
  "uhs-robert/sshfs.nvim",
  opts = {
    connections = {
      sshfs_args = {
        "-o follow_symlinks",
      },
    },
    -- Refer to the configuration section below
    -- or leave empty for default
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
        "~/projects/ULOD/",
        -- "~/projects/general-data-science/"
        "~/projects/correlation-research",
      },
    },
  },
}
