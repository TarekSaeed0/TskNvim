local heirline_utils = require("heirline.utils")

local icon = {
	init = function(self)
		local name = vim.api.nvim_buf_get_name(self.buffer)
		local stat = vim.uv.fs_stat(name)
		if stat and stat.type == "directory" then
			self.icon, self.color = "", require("nvim-web-devicons").get_default_icon().color
		else
			self.icon, self.color =
				require("nvim-web-devicons").get_icon_color(vim.fn.fnamemodify(name, ":t"), vim.fn.fnamemodify(name, ":e"))
			if self.icon == nil then
				self.icon, self.color = "", require("nvim-web-devicons").get_default_icon().color
			end
		end
	end,
	{
		provider = function(self)
			return " " .. (self.icon or "")
		end,
		hl = function(self)
			return { fg = self.color, bold = false }
		end,
	},
	update = { "BufAdd", "BufEnter", "BufLeave", "FocusGained", "FocusLost" },
}

local path = {
	init = function(self)
		local separator = package.config:sub(1, 1)
		local ellipsis = "…"

		local components = self.path_suffix

		local child = { flexible = 50 }

		child[1] = {
			{ provider = " " },
			{
				provider = table.concat(components, separator, 1, #components - 1) .. (#components > 1 and separator or ""),
				hl = { fg = heirline_utils.get_highlight("TabLine").fg, bold = false },
			},
			{
				provider = components[#components],
			},
			{ provider = " " },
		}
		for i = 2, #components - 1 do
			child[i] = {
				{ provider = " " },
				{
					{
						provider = components[1],
					},
					{
						provider = separator
							.. ellipsis
							.. separator
							.. table.concat(components, separator, i + 1, #components - 1)
							.. (#components > i + 1 and separator or ""),
					},
					hl = { fg = heirline_utils.get_highlight("TabLine").fg, bold = false },
				},
				{
					provider = components[#components],
				},
				{ provider = " " },
			}
		end
		child[#components + 1] = nil

		self[1] = self:new(child)
	end,
	update = { "BufAdd", "BufEnter", "BufLeave", "DirChanged", "VimResized", "FocusGained", "FocusLost" },
}

local diagnostics = {
	flexible = 60,
	init = function(self)
		self.error_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.ERROR })
		self.warning_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.WARN })
		self.information_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.INFO })
		self.hint_count = #vim.diagnostic.get(self.buffer, { severity = vim.diagnostic.severity.HINT })
	end,
	condition = function(self)
		return not self.is_active and #vim.diagnostic.get(self.buffer) ~= 0
	end,
	update = { "DiagnosticChanged", "BufEnter", "BufLeave" },
}

local diagnostics_components = {
	{
		provider = function(self)
			return " " .. self.error_count .. " "
		end,
		hl = "DiagnosticError",
		condition = function(self)
			return self.error_count ~= 0
		end,
	},
	{
		provider = function(self)
			return " " .. self.warning_count .. " "
		end,
		hl = "DiagnosticWarn",
		condition = function(self)
			return self.warning_count ~= 0
		end,
	},
	{
		provider = function(self)
			return " " .. self.information_count .. " "
		end,
		hl = "DiagnosticInfo",
		condition = function(self)
			return self.information_count ~= 0
		end,
	},
	{
		provider = function(self)
			return "󰌵 " .. self.hint_count .. " "
		end,
		hl = "DiagnosticHint",
		condition = function(self)
			return self.hint_count ~= 0
		end,
	},
}

diagnostics[#diagnostics_components + 1] = { provider = "" }
for i = #diagnostics_components, 1, -1 do
	diagnostics[i] = { diagnostics_components[i], (table.unpack or unpack)(diagnostics[i + 1]) }
end

local modified = {
	{
		provider = "●",
		hl = {
			fg = "green",
			bold = false,
		},
		on_click = {
			callback = function(_, buffer)
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buffer) then
						vim.api.nvim_buf_call(buffer, vim.cmd.write)
					end
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.buffer
			end,
			name = "heirline_buffer_write_callback",
		},
	},
	{ provider = " " },
	condition = function(self)
		return vim.api.nvim_get_option_value("modified", { buf = self.buffer })
	end,
	update = { "BufModifiedSet", "BufEnter", "BufLeave" },
}

local readonly = {
	provider = " ",
	hl = {
		fg = "yellow",
		bold = false,
	},
	condition = function(self)
		return not vim.api.nvim_get_option_value("modifiable", { buf = self.buffer })
			or vim.api.nvim_get_option_value("readonly", { buf = self.buffer })
	end,
}

local close_button = {
	{
		provider = "",
		on_click = {
			callback = function(_, buffer)
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buffer) then
						Snacks.bufdelete(buffer)
					end
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.buffer
			end,
			name = "heirline_buffer_close_callback",
		},
	},
	{ provider = " " },
	condition = function(self)
		return not vim.api.nvim_get_option_value("modified", { buf = self.buffer })
	end,
	update = { "BufModifiedSet", "BufEnter", "BufLeave", "FocusGained", "FocusLost" },
}

local buffer_template = {
	{
		provider = "",
		hl = function(self)
			return {
				fg = heirline_utils.get_highlight(self.is_active and "TabLineSel" or "TabLine").bg,
				bg = heirline_utils.get_highlight("TabLineFill").bg,
			}
		end,
	},
	icon,
	path,
	diagnostics,
	modified,
	readonly,
	close_button,
	{
		provider = "",
		hl = function(self)
			return {
				fg = heirline_utils.get_highlight(self.is_active and "TabLineSel" or "TabLine").bg,
				bg = heirline_utils.get_highlight("TabLineFill").bg,
			}
		end,
	},
	hl = function(self)
		return self.is_active and "TabLineSel" or "TabLine"
	end,
	on_click = {
		callback = function(_, buffer, _, button)
			if button == "l" then
				vim.api.nvim_win_set_buf(0, buffer)
			elseif button == "m" then
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(buffer) then
						Snacks.bufdelete(buffer)
					end
					vim.cmd.redrawtabline()
				end)
			end
		end,
		minwid = function(self)
			return self.buffer
		end,
		name = "heirline_buffer_callback",
	},
	update = {
		"BufEnter",
		"BufLeave",
		"BufModifiedSet",
		"BufWritePost",
		"DirChanged",
		"VimResized",
		"FocusGained",
		"FocusLost",
	},
}

local next_page_button = {
	{ provider = " " },
	{
		{
			provider = "",
			hl = { fg = "accent" },
		},
		{
			provider = "󰜴",
			hl = {
				fg = "accent",
				reverse = true,
				bold = true,
			},
		},
		{
			provider = "",
			hl = { fg = "accent" },
		},
		on_click = {
			callback = function(self)
				self.shared.page = math.min(self.shared.page_count, self.shared.page + 1)
				self.shared.page_forced = true

				self.shared.parent:broadcast(function(child)
					child._win_cache = nil
				end)
				vim.cmd.redrawtabline()
			end,
			name = "heirline_buffers_next_page_callback",
		},
	},
	condition = function(self)
		return self.shared.page < self.shared.page_count
	end,
}

local previous_page_button = {
	{
		{
			provider = "",
			hl = { fg = "accent" },
		},
		{
			provider = "󰜱",
			hl = {
				fg = "accent",
				reverse = true,
				bold = true,
			},
		},
		{
			provider = "",
			hl = { fg = "accent" },
		},
		on_click = {
			callback = function(self)
				self.shared.page = math.max(1, self.shared.page - 1)
				self.shared.page_forced = true

				self.shared.parent:broadcast(function(child)
					child._win_cache = nil
				end)
				vim.cmd.redrawtabline()
			end,
			name = "heirline_buffers_previous_page_callback",
		},
	},
	{ provider = " " },
	condition = function(self)
		return self.shared.page > 1
	end,
}

---given a list of paths, return a list of the shortest suffix pathes, such that there is no ambiguity
---@param paths string[][]
---@return string[][]
local function unique_path_suffixes(paths)
	local root = {}

	for _, path in ipairs(paths) do
		local node = root
		for i = #path, 1, -1 do
			local component = path[i]
			node.children = node.children or {}
			node.children[component] = node.children[component] or { children_count = 0 }
			node = node.children[component]
			node.children_count = node.children_count + 1
		end
	end

	local suffixes = {}
	for i, path in ipairs(paths) do
		local node = root
		local suffix = {}
		for j = #path, 1, -1 do
			local component = path[j]
			node = node.children[component]
			table.insert(suffix, 1, component)
			if node.children_count == 1 then
				break
			end
		end

		suffixes[i] = suffix
	end

	return suffixes
end

---given a component, return its minimum width, after contracting all flexible sub-components
---@param component StatusLine
---@return integer
local function minimum_component_width(component)
	if component.condition and not component:condition() then
		return 0
	end

	if component.init then
		component:init()
	end

	if rawget(component, "flexible") then
		return minimum_component_width(component[#component])
	elseif rawget(component, "provider") then
		local provider = type(component.provider) == "function" and (component.provider(component) or "")
			or (component.provider or "")
		return heirline_utils.count_chars(provider)
	else
		local width = 0
		for i = 1, #component do
			width = width + minimum_component_width(component[i])
		end
		return width
	end
end

local buffers = {
	init = function(self)
		self.shared = self.shared
			or {
				parent = self,
				children = {},
				page_forced = false,
				page_count = 1,
				page_starts = { 1 },
				page_ends = { 1 },
				page = 1,
			}
	end,
	previous_page_button,
	{
		init = function(self)
			self.buffers = vim.tbl_filter(function(buffer)
				return vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_get_option_value("buflisted", { buf = buffer })
			end, vim.api.nvim_list_bufs())

			local separator = package.config:sub(1, 1)

			local children = {}
			for index, buffer in ipairs(self.buffers) do
				local child = self.shared.children[index]
				if not (child and child.buffer == buffer) then
					child = self:new(buffer_template, index)
					child.buffer = buffer
					child.path =
						vim.split(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":~"):gsub("%%", "%%%%"), separator)
				end

				children[index] = child

				if buffer == tonumber(vim.g.actual_curbuf) and vim.g.tsknvim_in_focus then
					if not child.is_active then
						self.shared.page_forced = false
					end
					child.is_active = true
				else
					child.is_active = false
				end
			end

			local paths = {}
			for i, child in ipairs(children) do
				paths[i] = child.path
			end

			local path_suffixes = unique_path_suffixes(paths)
			for i, child in ipairs(children) do
				child.path_suffix = path_suffixes[i]
			end

			self.shared.children = children

			local maximum_page_width = vim.opt.columns:get() - 4 - 4 - 3
			local page_count = 1
			local page_width = 0
			local page_starts = { 1 }
			local page_ends = {}
			for index = 1, #self.shared.children do
				local width = minimum_component_width(self.shared.children[index])
				if page_width + width > maximum_page_width and page_starts[page_count] < index then
					page_ends[page_count] = index - 1
					page_count = page_count + 1
					page_starts[page_count] = index
					page_width = width
				else
					page_width = page_width + width
				end
				if not self.shared.page_forced and self.shared.children[index].is_active then
					self.shared.page = page_count
				end
			end
			page_ends[page_count] = #self.buffers

			self.shared.page_count = page_count
			self.shared.page_starts = page_starts
			self.shared.page_ends = page_ends
			self.shared.page = math.min(self.shared.page, page_count)

			for i = self.shared.page_starts[self.shared.page], self.shared.page_ends[self.shared.page] + 1 do
				self[i - self.shared.page_starts[self.shared.page] + 1] = self.shared.children[i]
			end
			for i = self.shared.page_ends[self.shared.page] - self.shared.page_starts[self.shared.page] + 2, #self do
				self[i] = nil
			end
		end,
		update = {
			"BufAdd",
			"BufDelete",
			"BufEnter",
			"BufLeave",
			"BufModifiedSet",
			"BufWritePost",
			"DirChanged",
			"VimResized",
			"FocusGained",
			"FocusLost",
		},
	},
	{
		provider = "  ",
		on_click = {
			callback = function(_, _, _, button)
				if button == "l" then
					vim.cmd.enew()
				end
			end,
			name = "heirline_buffer_new_callback",
		},
		hl = {
			fg = "green",
			bold = true,
		},
	},
	{ provider = "%=" },
	next_page_button,
}

return buffers
