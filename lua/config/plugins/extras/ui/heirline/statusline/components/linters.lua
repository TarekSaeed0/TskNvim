local linters = {
	flexible = 0,
	{
		provider = function(self)
			local string = " 󱉶"
			for _, linter in ipairs(self.linters) do
				string = string .. " " .. linter
			end
			return string
		end,
		condition = function(self)
			if not LazyVim.is_loaded("nvim-lint") then
				return false
			end

			self.linters = require("lint").get_running()

			return #self.linters ~= 0
		end,
	},
	{ provider = "" },
}

return linters
