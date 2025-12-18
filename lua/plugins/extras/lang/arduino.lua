return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "arduino",
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				arduino_language_server = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "arduino" } },
	},
}
