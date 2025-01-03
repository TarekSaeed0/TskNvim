---@type LazySpec[]
return {
	{
		"folke/which-key.nvim",
		---@type wk.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			preset = "modern",
			delay = vim.opt.timeoutlen:get(),
			win = {
				border = "rounded",
				wo = {
					winblend = vim.opt.winblend:get(),
					winhighlight = "NormalFloat:NormalFloatNC",
				},
			},
			spec = {
				{
					{ "<leader>d", group = "debug" },
					{ "<leader>gh", group = "hunks" },
					{ "[", group = "previous" },
					{ "]", group = "next" },
					{ "z", group = "fold" },
					{ "gx", desc = "Open with system app" },
				},
			},
		},
		---@param opts wk.Config
		config = function(_, opts)
			vim.opt.timeoutlen = 200

			require("which-key").setup(opts)
		end,
		event = "VeryLazy",
		cmd = "WhichKey",
	},
}
