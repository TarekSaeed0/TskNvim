return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = false,
				virtual_lines = true,
				float = { border = "rounded" },
			},
			servers = {
				rust_analyzer = { mason = false },
			},
		},
	},
}
