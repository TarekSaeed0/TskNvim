local tabline = { hl = "TabLineFill" }

local offset = require("config.plugins.extras.ui.heirline.tabline.components.offset")
table.insert(tabline, offset)

local buffers = require("config.plugins.extras.ui.heirline.tabline.components.buffers")
table.insert(tabline, buffers)

return tabline
