return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "vhdl",
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vhdl_ls = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "vhdl" } },
	},
}
