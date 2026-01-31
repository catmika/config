-- ✅ Neogit: Git interface
return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		-- "nvim-telescope/telescope.nvim", -- Commented out: using fzf.vim instead
	},
	config = function()
		require("neogit").setup({
			diffview = true,
		})
	end,
}
