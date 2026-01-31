local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	--	🔍 Telescope: fuzzy finder
	{
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
	},
	-- 🔍 Grug: find and replace
	{
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
	},
	{
		-- 🌳 Treesitter: parser generator tool
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
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
	},
	-- 🌳 Treesitter context: UI for context (scope) of the code block you are currently in
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},
	-- 💡 LSP: Language server protocol
	{
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
	},
	-- 🗺️ File tree: navigation tree
	{
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
	},
	-- 𓊆 𓊇 𓊈 𓊉 𓉘 𓉝 Surround: Comfortable work with surroundings in text
	{
		"nvim-mini/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	-- 𓊆 𓊇 𓊈 𓊉 𓉘 𓉝 Pairs: Automatic adding and deletion of closing surrounding character
	{
		"nvim-mini/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	-- 📟 Lualine: Status line
	{
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
	},
	-- 📟 Bufferline: Buffer line
	{
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
	},
	-- 🎨 Catppuccin: theme
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin-macchiato")
	-- 	end,
	-- },
	-- 🎨 Github: theme
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	name = "github-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("github-theme").setup({})
	-- 		vim.cmd("colorscheme github_dark_default")
	-- 	end,
	-- },
	-- 🎨 Everforest: theme
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	version = false,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			background = "hard",
	-- 		})
	-- 		vim.cmd.colorscheme("everforest")
	-- 	end,
	-- },
	-- 🎨 Gruvbox: theme
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	-- 💅 Conform: formatting
	{
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
	},
	-- 💬 Comment and ts-comments: Shortcut for comments and context aware comments
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	-- ✍️ Cmp: Autocompletion, inlay hits
	{
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
							Text = "",
							Method = "",
							Function = "󰊕",
							Constructor = "",
							Field = "",
							Variable = "",
							Class = "",
							Interface = "",
							Module = "",
							Property = "",
							Unit = "",
							Value = "",
							Enum = "",
							Keyword = "",
							Snippet = "",
							Color = "",
							File = "",
							Reference = "",
							Folder = "",
							EnumMember = "",
							Constant = "",
							Struct = "",
							Event = "",
							Operator = "",
							TypeParameter = "",
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
							-- Show relative tail of path/module if it’s too long
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
	},
	-- 📌 Persistence: Recreating previous session after exit
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		module = "persistence",
		config = function()
			require("persistence").setup({
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	-- 🚧 Gitsigns: Git visual sideline signs
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next git hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Previous git hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selected hunk" })

					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selected hunk" })

					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Blame line" })

					map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })

					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, { desc = "Diff this (cached)" })

					map("n", "<leader>hQ", function()
						gitsigns.setqflist("all")
					end, { desc = "All hunks to quickfix" })
					map("n", "<leader>hq", gitsigns.setqflist, { desc = "Buffer hunks to quickfix" })

					-- Toggles
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
					map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

					-- Text object
					map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
				end,
			})
		end,
	},
	-- ✅ Neogit: Git interface
	{
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
	},
	-- 🤖 Claude-code: Claude AI agent
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("claude-code").setup()
		end,
	},
	-- ℹ️ Which key: Available keybindings popup
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
})

-- Disable LSP diagnostics for .env files (they're just variable declarations)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { ".env*", "*.env.*" },
	callback = function(args)
		vim.diagnostic.disable(args.buf)
	end,
})

-- Enable errors inlay hints
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
})
