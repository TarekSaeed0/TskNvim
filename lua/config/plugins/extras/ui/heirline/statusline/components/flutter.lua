local flutter = {
	{
		provider = function()
			return "  " .. vim.g.flutter_tools_decorations.app_version
		end,
		condition = function()
			return vim.g.flutter_tools_decorations.app_version
		end,
	},
	{
		provider = function()
			return " 󰾰 " .. vim.g.flutter_tools_decorations.device
		end,
		condition = function()
			return vim.g.flutter_tools_decorations.device
		end,
	},
	condition = function()
		return vim.g.flutter_tools_decorations
	end,
}

return flutter
