vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

return {
	"sidebar-nvim/sidebar.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{
			"<leader>e",
			function()
				require("sidebar-nvim").focus()
			end,
			noremap = true,
			silent = true,
		},
	},
	lazy = false,
	config = function()
		require("sidebar-nvim").setup({
			open = true,
			bindings = {
				["<c-r>"] = function()
					require("sidebar-nvim").update()
				end,
			},
			sections = {
				"git",
				"files",
				"symbols",
				"diagnostics",
				"todos",
			},
			files = {
				show_hidden = true,
			},
		})

		local timer = vim.loop.new_timer()
		timer:start(
			1000,
			1000,
			vim.schedule_wrap(function()
				require("sidebar-nvim").update()
			end)
		)
	end,
}