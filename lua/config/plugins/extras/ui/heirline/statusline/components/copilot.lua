local copilot = {
	init = function(self)
		local client = require("copilot.client")
		local status = require("copilot.status").data.status
		if client.is_disabled() then
			self.status = "disabled"
		elseif status == "InProgress" then
			self.status = "loading"
		elseif status == "Warning" then
			self.status = "error"
		elseif
			vim.b.copilot_suggestion_auto_trigger and require("copilot.config").suggestion.auto_trigger
			or vim.b.copilot_suggestion_auto_trigger
		then
			self.status = "sleep"
		else
			self.status = "enabled"
		end

		if self.status == "loading" then
			if self.loading_frame == nil then
				self.loading_frame = 1
				self.loading_frame_start = os.clock()
			else
				if os.clock() - self.loading_frame_start > 0.25 / #self.icons.loading then
					if self.loading_frame < #self.icons.loading then
						self.loading_frame = self.loading_frame + 1
					else
						self.loading_frame = 1
					end
					self.loading_frame_start = os.clock()
				end
			end
		else
			self.loading_frame = nil
		end
	end,
	static = {
		icons = {
			enabled = " ",
			loading = { "◜", "◠", "◝", "◞", "◡", "◟" },
			error = " ",
			sleep = " ",
			disabled = " ",
		},
		hl = {
			enabled = { fg = "green" },
			loading = { fg = "yellow" },
			error = { fg = "red" },
			sleep = {},
			disabled = {},
		},
	},
	provider = function(self)
		if self.status == "loading" then
			return " " .. self.icons.loading[self.loading_frame]
		end
		return " " .. self.icons[self.status]
	end,
	hl = function(self)
		return self.hl[self.status]
	end,
	on_click = {
		callback = function()
			if LazyVim.has("CopilotChat.nvim") then
				require("CopilotChat").toggle()
			end
		end,
		name = "heirline_copilot_callback",
	},
	condition = function()
		return LazyVim.is_loaded("copilot.lua")
			and require("copilot.client").buf_is_attached(vim.api.nvim_get_current_buf())
	end,
}

return copilot
