local debugger = {
	flexible = 15,
	{
		provider = function(self)
			return "   " .. self.status
		end,
		condition = function(self)
			if not LazyVim.is_loaded("dap.nvim") then
				return false
			end

			self.status = require("dap").status()

			return self.status ~= ""
		end,
	},
	{ provider = "" },
}

return debugger
