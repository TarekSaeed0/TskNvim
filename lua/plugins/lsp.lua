return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = false,
				virtual_lines = true,
				float = { border = "rounded" },
			},
			format = { timeout_ms = 60000 },
			servers = {
				rust_analyzer = { mason = false },
			},
		},
	},
}
