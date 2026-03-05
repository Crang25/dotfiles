return {
	"numToStr/Comment.nvim",

	-- sets up some basic mapping which can be used in NORMAL and VISUAL
	config = function()
    -- default maps:
    -- gc: line comment
    -- gb: block comment
		require("Comment").setup()
	end,
}
