return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = { "tex", "plaintex", "bib" },
			root = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
		})
	end,
	{ import = "lazyvim.plugins.extras.lang.tex" },
	{
		"lervag/vimtex",
		keys = {
			{ "<localleader>lf", "<plug>(vimtex-view)", ft = "tex" },
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				tex = { "latexindent" },
			},
		},
	},
}
