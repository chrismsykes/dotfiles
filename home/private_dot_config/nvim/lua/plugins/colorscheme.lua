return {
  -- Disable LazyVim's default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Use terminal colors instead of a theme
        vim.o.termguicolors = false
        vim.cmd("colorscheme default")
      end,
    },
  },
}
