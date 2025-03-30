return {
	{
		"Zeioth/compiler.nvim",
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		keys = {
			{
				"<localleader>co",
				"<cmd>CompilerOpen<cr>",
				desc = "Open Compiler",
			},
			{
				"<localleader>cO",
				"<cmd>CompilerToggleResults<cr>",
				desc = "Toggle Compiler Results",
			},
			{
				"<localleader>cr",
				"<cmd>CompilerRedo<cr>",
				desc = "Redo Compiler",
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
		opts = {
			task_list = {
				direction = "bottom",
				max_height = { 20, 0.3 },
				default_detail = 1,
			},
		},
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
	},
}
