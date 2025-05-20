return {
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "luacheck" } },
		},
		opts = {
			linters_by_ft = {
				lua = { "luacheck" },
			},
		},
	},
}
