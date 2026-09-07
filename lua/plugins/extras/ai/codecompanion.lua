return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"ravitemer/codecompanion-history.nvim",
	},
	opts = {
		interactions = {
			chat = {
				adapter = {
					name = "opencode",
					model = "gpt-5.4-mini",
				},
			},
			inline = {
				adapter = {
					name = "opencode",
					model = "gpt-5.4-mini",
				},
			},
			-- Enable a background chat that will generate titles automatically
			background = {
				chat = {
					callbacks = {
						["on_ready"] = {
							actions = { "interactions.background.builtin.chat_make_title" },
							enabled = true,
						},
					},
					opts = { enabled = true },
				},
			},
		},

		extensions = {
			history = { enabled = true },
		},
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionActions",
		"CodeCompanionChat",
		"CodeCompanionCLI",
		"CodeCompanionCmd",
		"CodeCompanionHistory",
		"CodeCompanionSummaries",
	},
	keys = {
		{ "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
		{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
		{ "<leader>aA", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Code" },
		{ "<leader>ai", "<cmd>CodeCompanion", desc = "Inline Prompt" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Prompt Actions" },
		{ "<leader>ah", "<cmd>CodeCompanionHistory<cr>", desc = "Show History" },
		{ "<leader>as", "<cmd>CodeCompanionSummaries<cr>", desc = "Show Summaries" },
	},
}
