-- In ~/.config/nvim/lua/overseer/template/user/cargo_watch.lua
return {
  name = "cargo check watch",
  builder = function()
    return {
      cmd = { "bash" },
      args = {
        "-c",
        "export COLUMNS=$(tput cols); export LINES=$(tput lines); watch -c -x -n 1 cargo check"
      },
      components = {
        { "on_output_quickfix", open_on_match = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
}
