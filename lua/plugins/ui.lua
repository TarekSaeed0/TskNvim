return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
				backdrop = 100,
				height = 0.8,
			},
		},
	},
	{
		"folke/snacks.nvim",
		---@module "snacks"
		---@type snacks.Config
		opts = {
			indent = {
				indent = {
					char = "▏",
				},
				scope = {
					char = "▏",
				},
			},
			image = {
				enabled = true,
				doc = {
					float = false,
				},
				math = {
					latex = {
						font_size = "normalsize",
					},
				},
			},
			notifier = {
				margin = { right = 0 },
			},
			picker = {
				---@diagnostic disable-next-line: missing-fields
				icons = {
					files = {
						dir = " ",
						dir_open = " ",
					},
				},
			},
			statuscolumn = { enabled = false },
			terminal = {
				---@diagnostic disable-next-line: missing-fields
				win = {
					wo = {
						winbar = "",
					},
				},
			},
			dashboard = {
				preset = {
					---@type snacks.dashboard.Item[]
					keys = {
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					header = [[                ██  ██  ██  ██████                
                ██  ██  ██      ██                
                ██  ██  ██  ██████                
                ██  ██  ██  ██  ██                
        ██████  ██  ██  ██  ██████  ██████        
        ██  ██  ██  ██  ██  ██      ██  ██        
        ██████████████  ██  ██████  ██████        
                            ██      ██            
██████████  ██  ██  ██  ██  ██████  ██████████████
██  ██  ██  ██  ██  ██  ██  ██      ██            
██  ██████████████████████  ██████  ██████████████
                            ██                    
██████████████  ██████  ██  ██████  ██████████████
                    ██                            
██████████████  ██████  ██████████████████████  ██
            ██      ██  ██  ██  ██  ██  ██  ██  ██
██████████████  ██████  ██  ██  ██  ██  ██████████
            ██      ██                            
        ██████  ██████  ██  ██████████████        
        ██  ██      ██  ██  ██  ██  ██  ██        
        ██████  ██████  ██  ██  ██  ██████        
                ██  ██  ██  ██  ██                
                ██████  ██  ██  ██                
                ██      ██  ██  ██                
                ██████  ██  ██  ██                ]],
				},
				formats = {
					icon = function(item)
						if item.file and item.icon == "file" or item.icon == "directory" then
							return Snacks.dashboard.icon(item.file, item.icon)
						end
						return {
							{ "", hl = "SnacksDashboardIconLeftSeparator" },
							{ " " .. item.icon, width = 3, hl = "icon" },
							{ "", hl = "SnacksDashboardIconRightSeparator" },
						}
					end,
					desc = function(item)
						return {
							{ " " .. item.desc .. " ", hl = "desc", width = 17 },
							{ "", hl = "SnacksDashboardDescRightSeparator" },
						}
					end,
					key = function(item)
						return {
							{ "", hl = "SnacksDashboardKeyLeftSeparator" },
							{ " " .. item.key, width = 3, hl = "key" },
							{ "", hl = "SnacksDashboardKeyRightSeparator" },
						}
					end,
					footer = function(item)
						return { item.footer, align = "center" }
					end,
				},
				sections = {
					{ section = "header" },
					---@param opts? {icon?:string}
					---@return snacks.dashboard.Section?
					function(opts)
						opts = opts or {}
						Snacks.dashboard.lazy_stats = Snacks.dashboard.lazy_stats
								and Snacks.dashboard.lazy_stats.startuptime > 0
								and Snacks.dashboard.lazy_stats
							or require("lazy.stats").stats()
						local ms = (math.floor(Snacks.dashboard.lazy_stats.startuptime * 100 + 0.5) / 100)
						local icon = opts.icon or "󱐋 "
						return {
							align = "center",
							text = {
								{ "", hl = "SnacksDashboardFooterLeftSeparator" },
								{
									" "
										.. icon
										.. "Neovim loaded "
										.. Snacks.dashboard.lazy_stats.loaded
										.. "/"
										.. Snacks.dashboard.lazy_stats.count
										.. " plugins in "
										.. ms
										.. "ms ",
									hl = "footer",
								},
								{ "", hl = "SnacksDashboardFooterRightSeparator" },
							},
						}
					end,
					{ height = 1 },
					{ section = "keys" },
					{ height = 1 },
					---@return snacks.dashboard.Section?
					function()
						local version = vim.version()
						return {
							align = "center",
							text = {
								{ "", hl = "SnacksDashboardFooterLeftSeparator" },
								{
									("  Neovim" .. (version.prerelease and " nightly" or "") .. " v%d.%d.%d "):format(
										version.major,
										version.minor,
										version.patch
									),
									hl = "footer",
								},
								{ "", hl = "SnacksDashboardFooterRightSeparator" },
							},
						}
					end,
				},
			},
			styles = {
				---@diagnostic disable-next-line: missing-fields
				float = { backdrop = false },
				---@diagnostic disable-next-line: missing-fields
				notification = {
					wo = {
						winblend = 0,
						wrap = true,
					},
				},
				---@diagnostic disable-next-line: missing-fields
				zen = {
					backdrop = { bg = "#11111b", transparent = false, blend = 0 },
				},
				input = {
					width = 40,
					relative = "cursor",
					row = -3,
					col = 0,
				},
			},
		},
	},
	{
		"folke/noice.nvim",
		enabled = not vim.g.tsknvim_performance,
		opts = {
			presets = {
				bottom_search = false,
				command_palette = false,
				lsp_doc_border = true,
			},
			routes = {},
			lsp = {
				progress = {
					view = "notify",
				},
			},
			views = {
				notify = { replace = true },
			},
		},
	},
	{
		"echasnovski/mini.icons",
		opts = {
			default = {
				directory = { glyph = "", hl = "MiniIconsCyan" },
			},
		},
	},
}
