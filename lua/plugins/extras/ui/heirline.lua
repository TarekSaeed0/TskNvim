return {
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		enabled = false,
	},
	{
		"akinsho/bufferline.nvim",
		optional = true,
		enabled = false,
	},
	{
		"rebelot/heirline.nvim",
		event = "VeryLazy",
		opts = function()
			local statusline = require("config.plugins.extras.ui.heirline.statusline")

			local tabline = require("config.plugins.extras.ui.heirline.tabline")

			local statuscolumn = require("config.plugins.extras.ui.heirline.statuscolumn")

			return {
				statusline = statusline,
				tabline = tabline,
				statuscolumn = statuscolumn,
			}
		end,
		config = function(_, opts)
			vim.opt.foldcolumn = "auto"
			vim.opt.showcmdloc = "statusline"

			local heirline = require("heirline")

			heirline.setup(opts)

			local heirline_utils = require("heirline.utils")
			local function setup_colors()
				local colors = {
					foreground = heirline_utils.get_highlight("StatusLine").fg or "NONE",
					background = heirline_utils.get_highlight("StatusLine").bg or "NONE",
					accent = heirline_utils.get_highlight("Keyword").fg or "NONE",
					green = heirline_utils.get_highlight("DiagnosticOk").fg
						or heirline_utils.get_highlight("String").fg
						or "NONE",
					yellow = heirline_utils.get_highlight("DiagnosticWarn").fg or "NONE",
					red = heirline_utils.get_highlight("DiagnosticError").fg or "NONE",
				}

				if vim.g.colors_name:match("catppuccin") then
					colors = vim.tbl_extend("force", colors, require("catppuccin.palettes").get_palette())
				end

				return colors
			end

			heirline.load_colors(setup_colors())
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					heirline_utils.on_colorscheme(setup_colors)
				end,
			})
		end,
	},
}
