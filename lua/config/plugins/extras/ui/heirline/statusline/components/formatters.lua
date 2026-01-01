local formatters = {
	flexible = 10,
	{
		init = function(self)
			self.formatters = require("conform").list_formatters()
		end,
		provider = function(self)
			local string = " 󱍓"
			for _, formatter in ipairs(self.formatters) do
				string = string .. " " .. formatter.name
			end
			return string
		end,
		on_click = {
			callback = function()
				vim.cmd.ConformInfo()
			end,
			name = "heirline_formatters_callback",
		},
		condition = function()
			return LazyVim.is_loaded("conform.nvim") and #require("conform").list_formatters_for_buffer() ~= 0
		end,
		update = { "BufEnter", "BufWritePre" },
	},
}

return formatters
