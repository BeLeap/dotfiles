vim.keymap.set("n", "<leader>i", function()
	require("sidebar-nvim").toggle()
end, { noremap = true, silent = true })

require("sidebar-nvim").setup({
	open = true,
	bindings = {
		["<c-r>"] = function()
			require("sidebar-nvim").update()
		end,
	},
	sections = {
		"buffers",
		"git",
		"files",
		"symbols",
		"diagnostics",
		"todos",
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