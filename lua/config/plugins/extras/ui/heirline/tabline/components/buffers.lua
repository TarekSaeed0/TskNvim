local heirline_utils = require("heirline.utils")

local buffers = {
	{
		static = {
			buffer = {
				{
					provider = "",
					hl = function(self)
						return {
							fg = heirline_utils.get_highlight(self.is_active and "TabLineSel" or "TabLine").bg,
							bg = heirline_utils.get_highlight("TabLineFill").bg,
						}
					end,
				},
				{
					init = function(self)
						local name = vim.api.nvim_buf_get_name(self.buffer)
						local stat = vim.uv.fs_stat(name)
						if stat and stat.type == "directory" then
							self.icon, self.color = "", require("nvim-web-devicons").get_default_icon().color
						else
							self.icon, self.color = require("nvim-web-devicons").get_icon_color(
								vim.fn.fnamemodify(name, ":t"),
								vim.fn.fnamemodify(name, ":e")
							)
							if self.icon == nil then
								self.icon, self.color = "", require("nvim-web-devicons").get_default_icon().color
							end
						end
					end,
					{
						provider = function(self)
							return " " .. self.icon
						end,
						hl = function(self)
							return { fg = self.color, bold = false }
						end,
					},
					update = { "BufAdd", "BufEnter", "BufLeave", "FocusGained", "FocusLost" },
				},
				{
					init = function(self)
						local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buffer), ":~:."):gsub("%%", "%%%%")

						local separator = package.config:sub(1, 1)
						local ellipsis = "…"

						local components = vim.split(path, separator)

						local child = { flexible = 50 }

						child[1] = {
							{ provider = " " },
							{
								provider = table.concat(components, separator, 1, #components - 1)
									.. (#components > 1 and separator or ""),
								hl = { fg = heirline_utils.get_highlight("TabLine").fg, bold = false },
							},
							{
								provider = components[#components],
							},
							{ provider = " " },
						}
						for i = 2, #components do
							child[i] = {
								{ provider = " " },
								{
									provider = ellipsis
										.. separator
										.. table.concat(components, separator, i, #components - 1)
										.. (#components > i and separator or ""),
									hl = { fg = heirline_utils.get_highlight("TabLine").fg, bold = false },
								},
								{
									provider = components[#components],
								},
								{ provider = " " },
							}
						end
						child[#components + 1] = nil

						self[1] = self:new(child, 2)
					end,
					update = { "BufAdd", "BufEnter", "BufLeave", "DirChanged", "VimResized", "FocusGained", "FocusLost" },
				},
				(function()
					local diagnostics = {
						flexible = 60,
						init = function(self)
							self.error_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.ERROR })
							self.warning_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.WARN })
							self.information_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.INFO })
							self.hint_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.HINT })
						end,
						condition = function(self)
							return not self.is_active and #vim.diagnostic.get(self.buffer) ~= 0
						end,
						update = { "DiagnosticChanged", "BufEnter", "BufLeave" },
					}

					local components = {
						{
							provider = function(self)
								return " " .. self.error_count .. " "
							end,
							hl = "DiagnosticError",
							condition = function(self)
								return self.error_count ~= 0
							end,
						},
						{
							provider = function(self)
								return " " .. self.warning_count .. " "
							end,
							hl = "DiagnosticWarn",
							condition = function(self)
								return self.warning_count ~= 0
							end,
						},
						{
							provider = function(self)
								return " " .. self.information_count .. " "
							end,
							hl = "DiagnosticInfo",
							condition = function(self)
								return self.information_count ~= 0
							end,
						},
						{
							provider = function(self)
								return "󰌵 " .. self.hint_count .. " "
							end,
							hl = "DiagnosticHint",
							condition = function(self)
								return self.hint_count ~= 0
							end,
						},
					}

					diagnostics[#components + 1] = { provider = "" }
					for i = #components, 1, -1 do
						diagnostics[i] = { components[i], (table.unpack or unpack)(diagnostics[i + 1]) }
					end

					return diagnostics
				end)(),
				{
					{
						provider = "●",
						hl = {
							fg = "green",
							bold = false,
						},
						on_click = {
							callback = function(_, buffer)
								vim.schedule(function()
									if vim.api.nvim_buf_is_valid(buffer) then
										vim.api.nvim_buf_call(buffer, vim.cmd.write)
									end
									vim.cmd.redrawtabline()
								end)
							end,
							minwid = function(self)
								return self.buffer
							end,
							name = "heirline_buffer_write_callback",
						},
					},
					{ provider = " " },
					condition = function(self)
						return vim.api.nvim_get_option_value("modified", { buf = self.buffer })
					end,
					update = { "BufModifiedSet", "BufEnter", "BufLeave" },
				},
				{
					provider = " ",
					hl = {
						fg = "yellow",
						bold = false,
					},
					condition = function(self)
						return not vim.api.nvim_get_option_value("modifiable", { buf = self.buffer })
							or vim.api.nvim_get_option_value("readonly", { buf = self.buffer })
					end,
				},
				{
					{
						provider = "",
						on_click = {
							callback = function(_, buffer)
								vim.schedule(function()
									if vim.api.nvim_buf_is_valid(buffer) then
										Snacks.bufdelete(buffer)
									end
									vim.cmd.redrawtabline()
								end)
							end,
							minwid = function(self)
								return self.buffer
							end,
							name = "heirline_buffer_close_callback",
						},
					},
					{ provider = " " },
					condition = function(self)
						return not vim.api.nvim_get_option_value("modified", { buf = self.buffer })
					end,
					update = { "BufModifiedSet", "BufEnter", "BufLeave", "FocusGained", "FocusLost" },
				},
				{
					provider = "",
					hl = function(self)
						return {
							fg = heirline_utils.get_highlight(self.is_active and "TabLineSel" or "TabLine").bg,
							bg = heirline_utils.get_highlight("TabLineFill").bg,
						}
					end,
				},
				hl = function(self)
					return self.is_active and "TabLineSel" or "TabLine"
				end,
				on_click = {
					callback = function(_, buffer, _, button)
						if button == "l" then
							vim.api.nvim_win_set_buf(0, buffer)
						elseif button == "m" then
							vim.schedule(function()
								if vim.api.nvim_buf_is_valid(buffer) then
									Snacks.bufdelete(buffer)
								end
								vim.cmd.redrawtabline()
							end)
						end
					end,
					minwid = function(self)
						return self.buffer
					end,
					name = "heirline_buffer_callback",
				},
				update = {
					"BufEnter",
					"BufLeave",
					"BufModifiedSet",
					"BufWritePost",
					"DirChanged",
					"VimResized",
					"FocusGained",
					"FocusLost",
				},
			},
		},
		init = function(self)
			self.buffers = vim.tbl_filter(function(buffer)
				return vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_get_option_value("buflisted", { buf = buffer })
			end, vim.api.nvim_list_bufs())

			for index, buffer in ipairs(self.buffers) do
				local child = self[index]
				if not (child and child.buffer == buffer) then
					self[index] = self:new(self.buffer, index)
					child = self[index]
					child.buffer = buffer
				end

				if buffer == tonumber(vim.g.actual_curbuf) and vim.g.tsknvim_in_focus then
					child.is_active = true
				else
					child.is_active = false
				end
			end
			if #self > #self.buffers then
				for index = #self.buffers + 1, #self do
					self[index] = nil
				end
			end
		end,
		update = {
			"BufAdd",
			"BufDelete",
			"BufEnter",
			"BufLeave",
			"BufModifiedSet",
			"BufWritePost",
			"DirChanged",
			"VimResized",
			"FocusGained",
			"FocusLost",
		},
	},
	{
		provider = "  ",
		on_click = {
			callback = function(_, _, _, button)
				if button == "l" then
					vim.cmd.enew()
				end
			end,
			name = "heirline_buffer_new_callback",
		},
		hl = {
			fg = "green",
			bold = true,
		},
	},
}

return buffers
