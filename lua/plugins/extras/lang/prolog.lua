return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "prolog",
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				prolog = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "prolog" } },
	},
}
