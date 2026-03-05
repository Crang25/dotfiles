-- i got this soulution here:
-- https://github.com/nvim-telescope/telescope.nvim/issues/2602#issuecomment-1636809235
return {
	-- for scrolling preview window
	slow_scroll = function(action_state, state, prompt_bufnr, direction)
		local previewer = action_state.get_current_picker(prompt_bufnr).previewer
		local status = state.get_status(prompt_bufnr)

		-- Check if we actually have a previewer and a preview window
		if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
			return
		end

		previewer:scroll_fn(1 * direction)
	end,
}
