return {
	{
		"snacks.nvim",
		---@module "snacks"
		---@type snacks.Config
		opts = {
			dashboard = {
				preset = {
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
			},
		},
	},
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
					tree = { last = "┌╴" },
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
