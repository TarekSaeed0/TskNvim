local ffi = require("ffi")

ffi.cdef([[
	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/types_defs.h#L58
	typedef struct window_S win_T;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/types_defs.h#L16
	typedef int handle_T;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/api/private/defs.h#L14
	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/api/private/defs.h#L84C1-L84C21
	typedef handle_T Window;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/api/private/defs.h#L28
	typedef enum {
		kErrorTypeNone = -1,
		kErrorTypeException,
		kErrorTypeValidation,
	} ErrorType;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/api/private/defs.h#L63
	typedef struct {
		ErrorType type;
		char *msg;
	} Error;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/api/private/helpers.c#L316
	win_T *find_window_by_handle(Window window, Error *err);

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/pos_defs.h#L6
	typedef int32_t linenr_T;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/fold_defs.h#L7
	typedef struct {
		linenr_T fi_lnum;	///< line number where fold starts
		int fi_level;			///< level of the fold; when this is zero the
											///< other fields are invalid
		int fi_low_level;	///< lowest fold level that starts in the same line
		linenr_T fi_lines;
	} foldinfo_T;

	// https://github.com/neovim/neovim/blob/b8135a76b71f1af0d708e3dc58ccb58abad59f7c/src/nvim/fold.c#L308
	foldinfo_T fold_info(win_T *win, linenr_T lnum);
]])

---@class FoldInfo
---@field fi_lnum number
---@field fi_level number
---@field li_low_level number
---@field fi_lines number

---@param winid integer
---@param line integer
---@return FoldInfo
local function fold_info(winid, line)
	local window = ffi.C.find_window_by_handle(winid, ffi.new("Error"))
	local info = ffi.C.fold_info(window, line)

	local offsets = {
		fi_lnum = 0,
		fi_level = 4,
		fi_low_level = 8,
		fi_lines = 12,
	}

	local bytes = ffi.cast("const uint8_t *", ffi.new("foldinfo_T[1]", info))

	return {
		fi_lnum = ffi.cast("const linenr_T *", bytes + offsets.fi_lnum)[0],
		fi_level = ffi.cast("const int *", bytes + offsets.fi_level)[0],
		fi_low_level = ffi.cast("const int *", bytes + offsets.fi_low_level)[0],
		fi_lines = ffi.cast("const linenr_T *", bytes + offsets.fi_lines)[0],
	}
end

local foldcolumn = {
	static = {
		fold_open_icon = vim.opt.fillchars:get().foldopen,
		fold_closed_icon = vim.opt.fillchars:get().foldclose,
	},
	provider = function(self)
		local line = vim.v.lnum
		local info = fold_info(0, line)

		if info.fi_lnum == line then
			if info.fi_lines == 0 then
				return self.fold_open_icon .. " "
			else
				return self.fold_closed_icon .. " "
			end
		else
			return "  "
		end
	end,
	on_click = {
		callback = function(_, minwid)
			local line = vim.fn.getmousepos().line
			local info = fold_info(minwid, line)

			if info.fi_lnum ~= line then
				return
			end

			if info.fi_lines == 0 then
				vim.fn.win_execute(minwid, ("noautocmd %dfoldclose"):format(line))
			else
				vim.fn.win_execute(minwid, ("noautocmd %dfoldopen"):format(line))
			end
		end,
		name = "heirline_fold_callback",
		minwid = function()
			return vim.api.nvim_get_current_win()
		end,
	},
	condition = function()
		return vim.opt.foldcolumn:get() ~= "0"
	end,
}

return foldcolumn
