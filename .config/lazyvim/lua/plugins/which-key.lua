return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>cv", group = "virtualenv", icon = { icon = " " } },
        { "<leader>cM", group = "molten", icon = { icon = "󰠮", color = "orange" } },
      },
    },
  },
}
