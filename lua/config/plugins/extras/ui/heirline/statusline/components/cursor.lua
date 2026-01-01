local cursor = {
	init = function(self)
		self.line = vim.api.nvim_win_get_cursor(0)[1]
		self.lines = vim.api.nvim_buf_line_count(0)

		self.column = vim.fn.virtcol(".")
		self.columns = vim.fn.virtcol({ self.line, "$" })

		self.long_position = ("  %" .. tostring(self.lines):len() .. "d/%d:%" .. tostring(self.columns):len() .. "d/%d "):format(
			self.line,
			self.lines,
			self.column,
			self.columns
		)

		self.short_position = ("  %" .. tostring(self.lines):len() .. "d:%" .. tostring(self.columns):len() .. "d "):format(
			self.line,
			self.column
		)
	end,
	{
		flexible = 20,
		{
			{
				provider = function(self)
					return self.long_position
				end,
			},
			{
				provider = "  %P ",
			},
		},
		{
			provider = function(self)
				return self.long_position
			end,
		},
		{
			provider = function(self)
				return self.short_position
			end,
		},
	},
	update = { "CursorMoved", "CursorMovedI" },
}

return cursor
