return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "zsh",
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				bashls = {
					filetypes = { "sh", "zsh" },
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "zsh" } },
	},
	{
		"stevearc/conform.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "shfmt" } },
		},
		opts = {
			formatters_by_ft = {
				zsh = { "shfmt" },
			},
		},
	},
}
