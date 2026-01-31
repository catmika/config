-- 💬 Comment: Shortcut for comments
return {
	"echasnovski/mini.comment",
	event = "VeryLazy",
	config = function()
		require("mini.comment").setup()
	end,
}
