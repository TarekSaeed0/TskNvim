local codeium = {
	init = function(self)
		self.status = require("codeium.virtual_text").status()
	end,
	provider = function(self)
		if self.status.state == "completions" then
			return (" 󰘦 %" .. tostring(self.status.total):len() .. "d/%d:%"):format(self.status.current, self.status.total)
		else
			return " 󰘦 "
		end
	end,
	hl = function(self)
		if self.status == "waiting" then
			return "DiagnosticWarn"
		end
	end,
	condition = function()
		return LazyVim.is_loaded("blink.cmp")
	end,
}

return codeium
