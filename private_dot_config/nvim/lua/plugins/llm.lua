return {
	{
		"gsuuon/model.nvim",
		cmd = { "M", "Model", "Mchat" },
		init = function()
			vim.filetype.add({
				extension = {
					mchat = "mchat",
				},
			})
		end,
		ft = "mchat",
		keys = {
			{ "<C-m>d", ":Mdelete<cr>", mode = "n" },
			{ "<C-m>s", ":Mselect<cr>", mode = "n" },
			{ "<C-m><space>", ":Mchat<cr>", mode = "n" },
		},
		config = function()
			local ollama = require("model.providers.ollama")
			local starters = require("model.prompts.starters")
			local chats = require("model.prompts.chats")

			require("model").setup({
				chats = {
					llama = vim.tbl_deep_extend("force", chats["together:codellama"], {
						provider = ollama,
						params = {
							model = "llama3",
						},
					}),
				},
				prompts = {
					commit = vim.tbl_deep_extend("force", starters["commit"], {
						provider = ollama,
						params = {
							model = "llama3",
						},
					}),
				},
			})
		end,
	},
}
