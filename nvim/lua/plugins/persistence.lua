-- 📌 Persistence: Recreating previous session after exit
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	module = "persistence",
	config = function()
		require("persistence").setup({
			options = { "buffers", "curdir", "tabpages", "winsize" },
		})
	end,
}
