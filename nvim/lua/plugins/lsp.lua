-- 💡 LSP: Language server protocol
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
				"bashls",
				"jsonls",
				"yamlls",
				"html",
				"cssls",
				"eslint",
				"marksman",
				"dockerls",
				"docker_compose_language_service",
				"vimls",
				"sqlls",
				"tailwindcss",
				"vue_ls",
				"gopls",
			},
			automatic_enable = true,
		})
		-- cmp capabilities
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local lspconfig = require("lspconfig")
		lspconfig.ts_ls.setup({ capabilities = capabilities })
		lspconfig.lua_ls.setup({ capabilities = capabilities })
		lspconfig.pyright.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })
	end,
}
