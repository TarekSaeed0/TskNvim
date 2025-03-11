return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = { "tex", "plaintex", "bib" },
			root = { ".latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
		})
	end,
	{ import = "lazyvim.plugins.extras.lang.tex" },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if vim.fn.executable("tree-sitter") == 1 then
				if type(opts.ensure_installed) == "table" then
					vim.list_extend(opts.ensure_installed, { "latex" })
				else
					opts.ensure_installed = { "latex" }
				end
			end
		end,
	},
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
