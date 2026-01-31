-- 📟 Bufferline: Buffer line
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				sort_by = "directory",
				show_close_icon = false,
				show_buffer_close_icons = false,
				diagnostics = "nvim_lsp",
				-- numbers = "ordinal",
				separator_style = "thin",
				name_formatter = function(buf)
					local parent = vim.fn.fnamemodify(buf.path, ":h:t")
					return parent .. "/" .. buf.name
				end,
			},
		})
	end,
}
