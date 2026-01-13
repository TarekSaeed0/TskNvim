local heirline_utils = require("heirline.utils")

local left_offset = require("config.plugins.extras.ui.heirline.tabline.components.left_offset")
local buffers = require("config.plugins.extras.ui.heirline.tabline.components.buffers")
local right_offset = require("config.plugins.extras.ui.heirline.tabline.components.right_offset")

local tabline = {
	init = function(self)
		local left_offset_width = heirline_utils.count_chars(self[1]:traverse())
		local right_offset_width = heirline_utils.count_chars(self[3]:traverse())
		self.maximum_buffers_width = vim.opt.columns:get() - left_offset_width - right_offset_width
	end,
	left_offset,
	buffers,
	right_offset,
	hl = "TabLineFill",
}

return tabline
