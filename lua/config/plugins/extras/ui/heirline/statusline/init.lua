local statusline = { hl = "StatusLine" }

local left_seperator = {
	{
		provider = "",
		hl = { fg = "accent" },
	},
	hl = "Normal",
}
table.insert(statusline, left_seperator)

local mode = require("config.plugins.extras.ui.heirline.statusline.components.mode")
table.insert(statusline, mode)

local cwd = require("config.plugins.extras.ui.heirline.statusline.components.cwd")
table.insert(statusline, cwd)

local venv = require("config.plugins.extras.ui.heirline.statusline.components.venv")
table.insert(statusline, venv)

if LazyVim.has("gitsigns.nvim") then
	local git = require("config.plugins.extras.ui.heirline.statusline.components.git")
	table.insert(statusline, git)
end

local cmd = require("config.plugins.extras.ui.heirline.statusline.components.cmd")
table.insert(statusline, cmd)

table.insert(statusline, { provider = "%=" })

if LazyVim.has("flutter-tools.nvim") then
	local flutter = require("config.plugins.extras.ui.heirline.statusline.components.flutter")
	table.insert(statusline, flutter)
end

if LazyVim.has("nvim-lint") then
	local linters = require("config.plugins.extras.ui.heirline.statusline.components.linters")
	table.insert(statusline, linters)
end

if LazyVim.has("conform.nvim") then
	local formatters = require("config.plugins.extras.ui.heirline.statusline.components.formatters")
	table.insert(statusline, formatters)
end

if LazyVim.has("dap.nvim") then
	local debugger = require("config.plugins.extras.ui.heirline.statusline.components.debugger")
	table.insert(statusline, debugger)
end

local lsp = require("config.plugins.extras.ui.heirline.statusline.components.lsp")
table.insert(statusline, lsp)

if LazyVim.has("codeium.nvim") then
	local codeium = require("config.plugins.extras.ui.heirline.statusline.components.codeium")
	table.insert(statusline, codeium)
end

if LazyVim.has("copilot.lua") then
	local copilot = require("config.plugins.extras.ui.heirline.statusline.components.copilot")
	table.insert(statusline, copilot)
end

local cursor = require("config.plugins.extras.ui.heirline.statusline.components.cursor")
table.insert(statusline, cursor)

local right_seperator = {
	{
		provider = "",
		hl = { fg = "background" },
	},
	hl = "Normal",
}
table.insert(statusline, right_seperator)

return statusline
