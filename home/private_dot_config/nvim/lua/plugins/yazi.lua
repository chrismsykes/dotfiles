return {
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      { "<leader>fy", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Yazi (current file)" },
      { "<leader>fY", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
      { "<leader>fz", "<cmd>Yazi toggle<cr>", desc = "Yazi (resume last session)" },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
