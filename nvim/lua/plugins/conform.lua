-- 💅 Conform: formatting
return {
	"stevearc/conform.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				python = { "black" },
				lua = { "stylua" },
				go = { "gofmt", "goimports" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				vue = { "prettier" },
				sql = { "sqlfluff" },
			},
		})
	end,
}
