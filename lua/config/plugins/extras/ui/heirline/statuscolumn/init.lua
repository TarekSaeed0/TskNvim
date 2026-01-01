local statuscolumn = {
	init = function(self)
		self.cursor_line = vim.api.nvim_win_get_cursor(0)[1]

		self.mode = vim.fn.mode()

		self.visual_range = nil
		if
			self.mode:sub(1, 1):lower() == "v"
			or self.mode:sub(1, 1) == "\22"
			or self.mode:sub(1, 1):lower() == "s"
			or self.mode:sub(1, 1) == "\19"
		then
			local visual_line = vim.fn.line("v")

			self.visual_range = self.cursor_line > visual_line and { visual_line, self.cursor_line }
				or { self.cursor_line, visual_line }
		end
	end,
	{
		condition = function()
			return vim.v.virtnum == 0
		end,
	},
	{
		provider = "%=",
		condition = function()
			return vim.v.virtnum ~= 0
		end,
	},
	hl = function(self)
		if self.visual_range and self.visual_range[1] <= vim.v.lnum and vim.v.lnum <= self.visual_range[2] then
			if
				self.mode:sub(1, 1) == "V"
				or self.mode:sub(1, 1) == "S"
				or ((self.mode:sub(1, 1) == "v" or self.mode:sub(1, 1) == "s") and vim.v.lnum ~= self.visual_range[1])
			then
				return { fg = "subtext0", bg = "surface0" }
			else
				return { fg = "subtext0", bg = "mantle" }
			end
		end

		if vim.fn.foldclosed(vim.v.lnum) ~= -1 then
			if vim.v.lnum == self.cursor_line and vim.opt.cursorline:get() then
				return { bg = "surface0" }
			else
				return { fg = "subtext0", bg = "surface0" }
			end
		end

		if vim.v.lnum == self.cursor_line then
			if not self.visual_range and vim.opt.cursorline:get() then
				return "LineNr"
			else
				return "LineNrNC"
			end
		elseif vim.v.lnum > self.cursor_line then
			return "LineNrBelow"
		elseif vim.v.lnum < self.cursor_line then
			return "LineNrAbove"
		end
	end,
	condition = function(self)
		if vim.opt.buftype:get() == "help" then
			return false
		end

		if vim.opt.signcolumn:get():match("yes") then
			self.signcolumn = true
		elseif vim.opt.signcolumn:get():match("no") then
			self.signcolumn = false
		else
			local signs = vim.fn.sign_getplaced(vim.fn.bufname(), { group = "*" })
			for _, sign in ipairs(signs) do
				self.signcolumn = false
				if #sign.signs > 0 then
					self.signcolumn = true
					break
				end
			end
		end

		return vim.opt.number:get() or self.signcolumn
	end,
}

local signcolumn = require("config.plugins.extras.ui.heirline.statuscolumn.components.signcolumn")
table.insert(statuscolumn[1], signcolumn)

local numbercolumn = require("config.plugins.extras.ui.heirline.statuscolumn.components.numbercolumn")
table.insert(statuscolumn[1], numbercolumn)

local foldcolumn = require("config.plugins.extras.ui.heirline.statuscolumn.components.foldcolumn")
table.insert(statuscolumn[1], foldcolumn)

return statuscolumn
