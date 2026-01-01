local git = {
	init = function(self)
		if not rawget(self, "once") then
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					self._win_cache = nil
				end,
			})
			self.once = true
		end
	end,
	{
		init = function(self)
			---@diagnostic disable-next-line: undefined-field
			self.branch = vim.b.gitsigns_head
		end,
		provider = function(self)
			return "  " .. self.branch
		end,
		on_click = {
			callback = function()
				Snacks.picker.git_branches()
			end,
			name = "heirline_git_branch_callback",
		},
		condition = function()
			---@diagnostic disable-next-line: undefined-field
			return vim.b.gitsigns_head
		end,
	},
	{
		init = function(self)
			---@diagnostic disable-next-line: undefined-field
			self.add_count = vim.b.gitsigns_status_dict.added or 0
			---@diagnostic disable-next-line: undefined-field
			self.change_count = vim.b.gitsigns_status_dict.changed or 0
			---@diagnostic disable-next-line: undefined-field
			self.delete_count = vim.b.gitsigns_status_dict.removed or 0
		end,
		{
			provider = function(self)
				return "  " .. self.add_count
			end,
			hl = "GitSignsAdd",
			condition = function(self)
				return self.add_count ~= 0
			end,
		},
		{
			provider = function(self)
				return "  " .. self.change_count
			end,
			hl = "GitSignsChange",
			condition = function(self)
				return self.change_count ~= 0
			end,
		},
		{
			provider = function(self)
				return "  " .. self.delete_count
			end,
			hl = "GitSignsDelete",
			condition = function(self)
				return self.delete_count ~= 0
			end,
		},
		on_click = {
			callback = function()
				Snacks.picker.git_status()
			end,
			name = "heirline_git_status_callback",
		},
		condition = function()
			---@diagnostic disable-next-line: undefined-field
			return vim.b.gitsigns_status_dict
		end,
	},
	-- FIX: temporarily disabled because I don't know how to add both GitSignsUpdate and BufEnter
	update = {
		"User",
		pattern = { "GitSignsUpdate", "GitSignsChanged" },
	},
}

return git
