local left_offset = require("config.plugins.extras.ui.heirline.tabline.components.left_offset")
local buffers = require("config.plugins.extras.ui.heirline.tabline.components.buffers")
local right_offset = require("config.plugins.extras.ui.heirline.tabline.components.right_offset")

local tabline = {
	left_offset,
	buffers,
	right_offset,
	hl = "TabLineFill",
}

return tabline
