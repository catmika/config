-- 🗺️ File tree: navigation tree
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		require("nvim-tree").setup({
			filters = {
				git_ignored = false,
				dotfiles = false,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
			view = {
				width = 45,
			},
		})
	end,
}
