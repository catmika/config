-- 📟 Lualine: Status line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_a = { { "filename", path = 3 } },
				lualine_b = { "branch" },
				lualine_c = { "tabs" },
				lualine_x = { "searchcount", "diagnostics" },
				lualine_y = { "diff" },
				lualine_z = { "filetype" },
			},
		})
	end,
}
