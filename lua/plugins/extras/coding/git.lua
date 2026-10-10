return {
	recommended = {
		ft = { "gitcommit", "gitconfig", "gitrebase", "gitignore", "gitattributes" },
	},
	{ import = "lazyvim.plugins.extras.lang.git" },
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "gitlint" } },
		},
		opts = {
			linters_by_ft = {
				gitcommit = { "gitlint" },
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			enhanced_diff_hl = true,
			use_icons = true,
			view = {
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
					winbar_info = true,
				},
			},
			file_panel = {
				listing_style = "list",
			},
		},
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
		keys = {
			{
				"<leader>gv",
				function()
					local lib = require("diffview.lib")
					if lib.get_current_view() then
						vim.cmd("DiffviewClose")
					else
						vim.cmd("DiffviewOpen")
					end
				end,
				desc = "Toggle Diffview",
			},
		},
	},
}
