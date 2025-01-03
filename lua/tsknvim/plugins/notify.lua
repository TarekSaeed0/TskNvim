---@type LazySpec[]
return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.notify = function(...)
				vim.notify = require("notify")
				return vim.notify(...)
			end
		end,
		---@type notify.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			max_width = function()
				return math.floor(vim.opt.columns:get() / 2)
			end,
			max_height = function()
				return math.floor(vim.opt.lines:get() / 2)
			end,
			stages = "slide",
			render = "compact",
		},
		---@param opts notify.Config
		config = function(_, opts)
			if require("tsknvim.utils").is_loaded("telescope.nvim") then
				require("telescope").setup({ extensions = { notify = { prompt_title = "Notifications" } } })
				require("telescope").load_extension("notify")
			end

			local function set_colors()
				local highlights = {
					NotifyDEBUGBody = { link = "NormalFloat" },
					NotifyERRORBody = { link = "NormalFloat" },
					NotifyINFOBody = { link = "NormalFloat" },
					NotifyTRACEBody = { link = "NormalFloat" },
					NotifyWARNBody = { link = "NormalFloat" },
					NotifyDEBUGBorder = { link = "FloatBorder" },
					NotifyERRORBorder = { link = "FloatBorder" },
					NotifyINFOBorder = { link = "FloatBorder" },
					NotifyTRACEBorder = { link = "FloatBorder" },
					NotifyWARNBorder = { link = "FloatBorder" },
				}
				for k, v in pairs(highlights) do
					vim.api.nvim_set_hl(0, k, v)
				end
			end

			set_colors()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_colors })

			require("notify").setup(opts)
		end,
		cmd = "Notifications",
		keys = {
			{

				"<leader>n",
				function()
					require("telescope").extensions.notify.notify()
				end,
				desc = "Notifications",
			},
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
	},
}
