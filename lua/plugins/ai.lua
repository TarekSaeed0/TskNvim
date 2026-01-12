return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
			init = function()
				vim.g.copilot_nes_debounce = 250
			end,
			---@module "copilot-lsp"
			---@type copilotlsp.config
			opts = {
				---@diagnostic disable-next-line: missing-fields
				nes = {
					move_count_threshold = 10,
				},
			},
		},
		opts = {
			nes = {
				enabled = true,
				keymap = {
					accept_and_goto = "<Tab>",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		},
	},
}
