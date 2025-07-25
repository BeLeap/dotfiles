return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>p",
        function()
          require("telescope").extensions.projects.projects()
        end,
        silent = true,
      },
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".nvim", "root.mark", ".git" },
        silent_chdir = true,
        show_hidden = true,
        exclude_dirs = {
          "*/node_modules/*",
          "/tmp/*",
        },
      })
      require("telescope").load_extension("projects")
    end,
  },
}
