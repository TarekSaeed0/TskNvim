local titles = {
	["trouble"] = "Symbols",
	["grug-far"] = "Search/Replace",
	["copilot-chat"] = "Copilot Chat",
}

local offset = {
	init = function(self)
		self.windows = {}
		for _, window in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local buffer = vim.api.nvim_win_get_buf(window)
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = buffer })

			if titles[filetype] then
				self.windows[filetype] = window
			end
		end
	end,
}

for filetype, title in pairs(titles) do
	table.insert(offset, {
		flexible = 70,
		{
			{
				provider = "│",
				hl = "WinSeparator",
			},
			{
				fallthrough = false,
				{
					{
						provider = function(self)
							return string.rep(" ", vim.api.nvim_win_get_width(self.window) - #title - 5)
						end,
					},
					{
						provider = "",
						hl = { fg = "accent" },
					},
					{
						provider = " " .. title .. " ",
						hl = {
							fg = "background",
							bg = "accent",
							bold = true,
						},
					},
					{
						{
							provider = "",
							hl = { fg = "accent" },
						},
						hl = "Normal",
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
			condition = function(self)
				local window = self.windows[filetype]
				if window then
					local position = vim.api.nvim_win_get_position(window)
					if position[1] == 1 then
						self.window = window
						self.title = title
						return true
					end
				end
			end,
		},
		{ provider = "" },
	})
end

return offset
