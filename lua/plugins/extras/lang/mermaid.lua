return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "mermaid",
		})
	end,
	{
		"folke/snacks.nvim",
		optional = true,
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "mmdc" } },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "mermaid" } },
	},
}
