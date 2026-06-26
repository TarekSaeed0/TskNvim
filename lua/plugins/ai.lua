return {
	{
		"zbirenbaum/copilot.lua",
		optional = true,
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
		---@module "copilot.config"
		---@type CopilotConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			nes = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept_and_goto = "<Tab>",
					accept = false,
					dismiss = "<Esc>",
				},
			},
		},
		event = function()
			return "InsertEnter"
		end,
	},
}
