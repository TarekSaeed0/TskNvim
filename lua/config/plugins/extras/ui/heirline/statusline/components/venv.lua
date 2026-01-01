local venv = {
	provider = function()
		return "  " .. vim.env.VIRTUAL_ENV_PROMPT
	end,
	condition = function()
		return vim.env.VIRTUAL_ENV_PROMPT
	end,
}

return venv
