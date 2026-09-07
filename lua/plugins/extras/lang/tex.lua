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
		init = function()
			vim.g.vimtex_syntax_conceal_disable = 1
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_format_enabled = 1
			vim.g.vimtex_quickfix_enabled = 0
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
					"-shell-escape",
				},
			}
		end,
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
