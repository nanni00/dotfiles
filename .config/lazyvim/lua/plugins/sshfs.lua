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
    mounts = {
      auto_change_dir_on_mount = true,
    },
    ui = {
      file_picker = {
        auto_open_on_mount = false,
      },
    },
  },
}
