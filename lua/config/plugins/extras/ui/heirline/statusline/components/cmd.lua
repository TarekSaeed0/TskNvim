local cmd = {
	{
		{
			provider = "  ",
			hl = { fg = "red", bold = true },
		},
		{
			provider = function()
				return "@" .. vim.fn.reg_recording()
			end,
		},
		condition = function()
			return vim.fn.reg_recording() ~= ""
		end,
		update = {
			"RecordingEnter",
			"RecordingLeave",
			callback = vim.schedule_wrap(function()
				vim.cmd.redrawstatus()
			end),
		},
	},
	{
		provider = function(self)
			return "  "
				.. string.format(
					"%" .. tostring(math.min(self.search.total, self.search.maxcount)):len() .. "d/%d",
					self.search.current,
					math.min(self.search.total, self.search.maxcount)
				)
		end,
		condition = function(self)
			if vim.v.hlsearch == 0 then
				return false
			end

			local success, search = pcall(vim.fn.searchcount)
			if success and search.total then
				self.search = search
				return true
			else
				return false
			end
		end,
	},
	{
		flexible = 30,
		{
			provider = " %0.5(%S%)",
			condition = function()
				return vim.opt.showcmdloc:get() == "statusline"
			end,
		},
		{ provider = "" },
	},
	condition = function()
		return vim.opt.cmdheight:get() == 0
	end,
}

return cmd
