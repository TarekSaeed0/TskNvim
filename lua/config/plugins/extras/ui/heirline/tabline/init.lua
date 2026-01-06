local tabline = { hl = "TabLineFill" }

local left_offset = require("config.plugins.extras.ui.heirline.tabline.components.left_offset")
table.insert(tabline, left_offset)

local buffers = require("config.plugins.extras.ui.heirline.tabline.components.buffers")
table.insert(tabline, buffers)

local right_offset = require("config.plugins.extras.ui.heirline.tabline.components.right_offset")
table.insert(tabline, right_offset)

return tabline
