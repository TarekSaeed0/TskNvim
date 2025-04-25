local function snake_case(s)
	return s:gsub("(%l)(%u)", "%1_%2"):gsub("[^a-zA-Z0-9_]", "_"):gsub("_+", "_"):gsub("_*$", ""):lower()
end

---@param task table
---@return string
local function format_contest(task)
	local hyphen = string.find(task.group, " - ")
	local judge, contest
	if not hyphen then
		judge = task.group
		contest = "unknown_contest"
	else
		judge = string.sub(task.group, 1, hyphen - 1)
		contest = string.sub(task.group, hyphen + 3)
	end

	return string.format(
		"%s/documents/competitive_programming/%s/%s",
		vim.uv.os_homedir(),
		snake_case(judge),
		snake_case(contest)
	)
end

---@param task table
---@param file_extension string
---@return string
local function format_problem(task, file_extension)
	local name = snake_case(task.name):gsub("^(%w)_", function(s)
		return s:upper()
	end)
	return string.format("%s.%s", name, file_extension)
end

return {
	{
		"xeluxee/competitest.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		---@module "competitest"
		---@type competitest.Config
		---@diagnostic disable-next-line: missing-fields
		opts = {
			---@diagnostic disable-next-line: missing-fields
			runner_ui = { show_nu = false },
			template_file = vim.fn.stdpath("config") .. "/templates/competitive_programming/src/main.cpp",
			testcases_directory = "testcases",
			received_files_extension = "cpp",
			received_problems_path = function(task, file_extension)
				return format_contest(task) .. "/" .. format_problem(task, file_extension)
			end,
			received_contests_problems_path = function(task, file_extension)
				return format_problem(task, file_extension)
			end,
			received_contests_directory = function(task)
				return format_contest(task)
			end,
			received_problems_prompt_path = false,
			received_contests_prompt_directory = false,
			received_contests_prompt_extension = false,
		},
		keys = {
			{ "<localleader>C", "", desc = "+competitest" },
			{ "<localleader>Cp", "<cmd>CompetiTest receive problem<cr>", desc = "Receive problem" },
			{ "<localleader>Cc", "<cmd>CompetiTest receive contest<cr>", desc = "Receive contest" },
			{ "<localleader>Cr", "<cmd>CompetiTest run<cr>", desc = "Run tests" },
		},
	},
}
