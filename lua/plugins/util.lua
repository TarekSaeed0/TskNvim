return {
	{
		"ahmedkhalf/project.nvim",
		opts = function()
			local patterns = vim.deepcopy(require("project_nvim.config").defaults.patterns)
			table.insert(patterns, "*")
			return { patterns = patterns }
		end,
	},
}
