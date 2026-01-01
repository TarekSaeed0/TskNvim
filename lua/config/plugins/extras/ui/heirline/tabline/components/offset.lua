local offset = {
	flexible = 70,
	{
		{
			fallthrough = false,
			{
				{
					{
						provider = "",
						hl = { fg = "accent" },
					},
					hl = "Normal",
				},
				{
					provider = function(self)
						return " " .. self.title .. " "
					end,
					hl = {
						fg = "background",
						bg = "accent",
					},
				},
				{
					provider = "╱",
					hl = { fg = "accent" },
				},
				{
					provider = function(self)
						return string.rep(" ", vim.api.nvim_win_get_width(self.window) - #self.title - 5)
					end,
				},
				condition = function(self)
					return vim.api.nvim_win_get_width(self.window) - #self.title - 5 >= 0
				end,
			},
			{
				provider = function(self)
					return string.rep(" ", vim.api.nvim_win_get_width(self.window))
				end,
			},
		},
		{
			provider = "│",
			hl = "WinSeparator",
		},
		condition = function(self)
			self.window = vim.api.nvim_tabpage_list_wins(0)[1]
			local buffer = vim.api.nvim_win_get_buf(self.window)

			if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "neo-tree" then
				self.title = "Explorer"
				return true
			end
		end,
	},
	{ provider = "" },
}

return offset
