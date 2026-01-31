-- 🌳 Treesitter context: UI for context (scope) of the code block you are currently in
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("treesitter-context").setup({
			enable = true,
		})
	end,
}
