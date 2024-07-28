return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    lazy = false,
    init = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
