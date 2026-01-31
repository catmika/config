-- 🔍 Grug: find and replace
return {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>gR",
			function()
				require("grug-far").open()
			end,
			desc = "Search and Replace",
		},
	},
	config = function()
		require("grug-far").setup({})
	end,
}
