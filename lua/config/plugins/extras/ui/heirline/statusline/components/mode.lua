local mode = {
	static = {
		names = {
			n = { "NORMAL", "N" },
			no = { "O-PENDING", "OP" },
			v = { "VISUAL", "V" },
			V = { "V-LINE", "VL" },
			["\22"] = { "V-BLOCK", "VB" },
			s = { "SELECT", "S" },
			S = { "S-LINE", "SL" },
			["\19"] = { "S-BLOCK", "SB" },
			i = { "INSERT", "I" },
			R = { "REPLACE", "R" },
			Rv = { "V-REPLACE", "VR" },
			c = { "COMMAND", "C" },
			cv = { "EX", "EX" },
			r = { "PROMPT", "E" },
			rm = { "MORE", "M" },
			["r?"] = { "CONFIRM", "CO" },
			["!"] = { "SHELL", "SH" },
			t = { "TERMINAL", "T" },
		},
	},
	init = function(self)
		local mode = vim.api.nvim_get_mode().mode
		self.name = vim
			.iter(mode:gmatch("."))
			:enumerate()
			:map(function(i)
				return mode:sub(1, -i)
			end)
			:map(function(s)
				return self.names[s]
			end)
			:next() or mode
	end,
	{
		flexible = 40,
		{
			provider = function(self)
				return "  " .. self.name[1] .. " "
			end,
		},
		{
			provider = function(self)
				return "  " .. self.name[2] .. " "
			end,
		},
		hl = {
			fg = "accent",
			reverse = true,
		},
	},
	{
		provider = "╲",
		hl = { fg = "accent" },
	},
	hl = { bold = true },
}

return mode
