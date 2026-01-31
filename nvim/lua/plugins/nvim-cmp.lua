-- ✍️ Cmp: Autocompletion, inlay hits
return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source
		"hrsh7th/cmp-buffer", -- buffer words
		"hrsh7th/cmp-path", -- filesystem paths
		"hrsh7th/cmp-cmdline", -- command-line completion
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- snippet completions
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-e>"] = cmp.mapping.confirm({ select = true }),
				["<C-o>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),

			-- 🧠 Make completion menu more informative
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind_icons = {
						Text = "",
						Method = "",
						Function = "󰊕",
						Constructor = "",
						Field = "",
						Variable = "",
						Class = "",
						Interface = "",
						Module = "",
						Property = "",
						Unit = "",
						Value = "",
						Enum = "",
						Keyword = "",
						Snippet = "",
						Color = "",
						File = "",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "",
						Event = "",
						Operator = "",
						TypeParameter = "",
					}

					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

					-- Try to grab more detailed source info
					local detail = entry.completion_item.detail or ""
					local origin = ""

					if entry.source.name == "nvim_lsp" then
						-- Some LSPs (like tsserver) include file/module info here
						origin = entry.completion_item.data and entry.completion_item.data.uri
							or detail:match("%S+%.%S+$") -- crude fallback: last part of detail
							or ""
					elseif entry.source.name == "path" then
						origin = entry.completion_item.label or ""
					end

					-- Clean it up
					if origin ~= "" then
						-- Show relative tail of path/module if it's too long
						origin = origin:gsub(".*[/\\]", "")
						detail = string.format("[%s]", origin)
					end

					vim_item.menu = string.format("[%s] %s", entry.source.name:gsub("^%l", string.upper), detail)

					return vim_item
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		-- Use buffer source in command-line
		cmp.setup.cmdline("/", {
			sources = {
				{ name = "buffer" },
			},
		})
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
