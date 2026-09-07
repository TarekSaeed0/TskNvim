return {
	{
		"GCBallesteros/jupytext.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "jupytext" } },
		},
		opts = {
			style = "markdown",
			output_extension = "md",
			force_ft = "markdown",
		},
	},
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		dependencies = { "quarto-dev/quarto-nvim" },
		init = function()
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_output_win_border = { "", "─", "", "" }
			vim.g.molten_output_win_cover_gutter = false
			vim.g.molten_output_win_style = "minimal"
		end,
		keys = {
			{ "<localleader>m", "", desc = "+molten", ft = "markdown" },
			{
				"<localleader>mi",
				function()
					vim.cmd.MoltenInit()

					require("quarto").activate()

					local runner = require("quarto.runner")

					vim.keymap.set("n", "<localleader>q", "", { desc = "+quarto", silent = true, buffer = true })

					vim.keymap.set("n", "<localleader>qc", runner.run_cell, { desc = "Run cell", silent = true, buffer = true })
					vim.keymap.set(
						"n",
						"<localleader>qa",
						runner.run_above,
						{ desc = "Run cell and above", silent = true, buffer = true }
					)
					vim.keymap.set(
						"n",
						"<localleader>qA",
						runner.run_all,
						{ desc = "Run all cells", silent = true, buffer = true }
					)
					vim.keymap.set("n", "<localleader>ql", runner.run_line, { desc = "run line", silent = true, buffer = true })
					vim.keymap.set(
						"v",
						"<localleader>q",
						runner.run_range,
						{ desc = "Run visual range", silent = true, buffer = true }
					)
				end,
				desc = "Initialize the plugin",
				ft = "markdown",
			},
			{ "<localleader>md", "<cmd>MoltenDeinit<cr>", desc = "Deinitialize the plugin", ft = "markdown" },
		},
	},
	{
		"quarto-dev/quarto-nvim",
		lazy = true,
		optional = true,
		dependencies = { "nvim-lspconfig", "jmbuhr/otter.nvim" },
		opts = {
			lspFeatures = {
				enabled = true,
				chunks = "all",
				diagnostics = {
					enabled = true,
					triggers = { "InsertLeave" },
				},
				completion = {
					enabled = true,
				},
			},
			codeRunner = {
				enabled = true,
				default_method = "molten",
			},
		},
	},
	{
		"jmbuhr/otter.nvim",
		lazy = true,
		optional = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
