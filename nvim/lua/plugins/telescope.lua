-- 🔍 Telescope: fuzzy finder
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",

	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep hidden=true no_ignore=true<cr>", desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers hidden=true no_ignore=true<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope search_history<cr>", desc = "Search history" },
		{ "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Color scheme" },
		{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Search last opened files" },
	},

	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"%.git/",
					"dist/",
					"build/",
					"%.-lock",
				},
				path_display = { "truncate" },
			},
		})
	end,
}
