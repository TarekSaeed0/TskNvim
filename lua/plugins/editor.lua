return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		opts = {
			default_component_configs = {
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
				},
				modified = {
					symbol = "●",
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		---@module "gitsigns"
		---@type Gitsigns.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			worktrees = {
				{
					toplevel = vim.env.HOME,
					gitdir = vim.env.HOME .. "/.dotfiles",
				},
			},
			preview_config = { border = "rounded" },
		},
	},
	{
		"folke/snacks.nvim",
		---@module "snacks"
		---@type snacks.Config
		opts = {
			picker = {
				layout = {
					preset = function()
						return vim.o.columns / vim.o.lines >= 2.4 and "default" or "vertical"
					end,
				},
				sources = {
					explorer = {
						auto_close = true,
						layout = {
							preset = function()
								return vim.o.columns / vim.o.lines >= 2.4 and "default" or "vertical"
							end,
							---@diagnostic disable-next-line: assign-type-mismatch
							preview = true,
							reverse = false,
						},
					},
				},
				layouts = {
					default = {
						reverse = true,
						layout = {
							width = 0.8,
							min_width = 0,
							height = 0.8,
							min_height = 0,
							box = "horizontal",
							{
								box = "vertical",
								{ win = "list", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{ win = "preview", title = "{preview}", border = "rounded", width = 0.6 },
						},
					},
					vertical = {
						reverse = true,
						layout = {
							width = 0.8,
							min_width = 0,
							height = 0.85,
							min_height = 0,
							box = "vertical",
							{ win = "preview", title = "{preview}", height = 0.6, border = "rounded" },
							{ win = "list", border = "rounded" },
							{ win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
						},
					},
					select = {
						layout = {
							width = 0.8,
							min_width = 0,
							max_width = 80,
						},
					},
					vscode = {
						layout = {
							row = 1,
							width = 0.8,
							min_width = 0,
							max_width = 80,
							height = 0.4,
							box = "vertical",
							{ win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
							{ win = "list", border = "rounded" },
							{ win = "preview", title = "{preview}", border = "rounded" },
						},
					},
				},
			},
		},
	},
}
