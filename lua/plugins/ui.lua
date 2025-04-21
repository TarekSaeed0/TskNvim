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
		config = function(_, opts)
			-- HACK: remove empty space after icon
			---@param self snacks.dashboard
			---@param item snacks.dashboard.Item
			---@diagnostic disable-next-line: inject-field
			require("snacks.dashboard").Dashboard.format = function(self, item)
				local width = item.indent or 0

				---@param fields string[]
				---@param opts {align?:"left"|"center"|"right", padding?:number, flex?:boolean, multi?:boolean}
				local function find(fields, opts)
					local flex = opts.flex and math.max(0, self.opts.width - width) or nil
					local texts = {} ---@type snacks.dashboard.Text[]
					for _, k in ipairs(fields) do
						if item[k] then
							vim.list_extend(texts, self:texts(self:format_field(item, k, flex)))
							if not opts.multi then
								break
							end
						end
					end
					if #texts == 0 then
						return { width = 0 }
					end
					local block = self:block(texts)
					block.width = block.width + (opts.padding or 0)
					width = width + block.width
					return block
				end

				local block = item.text and self:block(self:texts(item.text))
				local left = block and { width = 0 } or find({ "icon" }, { align = "left" })
				local right = block and { width = 0 } or find({ "label", "key" }, { align = "right" })
				local center = block or find({ "header", "footer", "title", "desc", "file" }, { flex = true, multi = true })

				local padding = self:padding(item)
				local ret = { width = self.opts.width } ---@type snacks.dashboard.Block
				for l = 1, math.max(#left, #center, #right, 1) + padding[1] do
					ret[l] = { width = 0 }
					left[l] = left[l] or { width = 0 }
					right[l] = right[l] or { width = 0 }
					center[l] = center[l] or { width = 0 }
					self:align(left[l], left.width, "left")
					if item.indent then
						self:align(left[l], left[l].width + item.indent, "right")
					end
					self:align(right[l], right.width, "right")
					self:align(center[l], self.opts.width - left[l].width - right[l].width, item.align)
					vim.list_extend(ret[l], left[l])
					vim.list_extend(ret[l], center[l])
					vim.list_extend(ret[l], right[l])
					ret[l].width = left[l].width + center[l].width + right[l].width
				end
				for _ = 1, padding[2] do
					table.insert(ret, 1, { width = self.opts.width })
				end
				return ret
			end

			require("snacks").setup(opts)
		end,
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
