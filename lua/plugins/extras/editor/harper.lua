return {
	--[[ recommended = function()
		return LazyVim.extras.wants({
			ft = { "markdown", "text", "tex", "typst", "gitcommit" },
		})
	end, ]]
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				harper_ls = {
					filetypes = { "markdown", "text", "tex", "typst", "gitcommit" },
				},
			},
		},
	},
}
