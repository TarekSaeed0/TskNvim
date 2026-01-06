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
						bold = true,
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
			for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				local buffer = vim.api.nvim_win_get_buf(window)
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = buffer })

				if filetype == "neo-tree" then
					self.window = window
					self.title = "Explorer"
					return true
				end
			end
		end,
	},
	{ provider = "" },
}

return offset
