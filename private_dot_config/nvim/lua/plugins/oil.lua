return {
	{
		"stevearc/oil.nvim",
    lazy = false,
		cmd = "Oil",
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
