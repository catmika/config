-- 🌳 Treesitter: parser generator tool
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"bash",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"html",
				"css",
				"markdown",
				"python",
				"go",
			},
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})

		vim.filetype.add({
			extension = {
				env = "sh",
			},
			filename = {
				[".env"] = "sh",
				[".env.local"] = "sh",
				[".env.development"] = "sh",
				[".env.production"] = "sh",
			},
			pattern = {
				[".*%.env.*"] = "sh",
			},
		})
	end,
}
