vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>Q", ":q<CR>", { desc = "Quit" })

keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Tree" })
keymap("n", "<leader>t", function()
	local winid = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("NvimTree_") then
			winid = win
			break
		end
	end

	if winid and vim.api.nvim_get_current_win() ~= winid then
		vim.api.nvim_set_current_win(winid) -- jump to tree
	else
		vim.cmd("wincmd p") -- jump back to last window
	end
end, { desc = "Focus Tree/Buffer" })

vim.keymap.set("n", "<leader>p", function()
	require("conform").format({ async = true })
end, { desc = "Format file" })

vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
vim.keymap.set("n", "<leader>0", "<Cmd>BufferLineGoToBuffer -1<CR>", { desc = "Go to last buffer" })
vim.keymap.set("n", "<leader>ba", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name ~= "" and not name:match("NvimTree_") then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end, { desc = "Close all buffers (keep NvimTree)" })

vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })

vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Prev warning" })

vim.keymap.set("n", "]i", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
end, { desc = "Next info" })

vim.keymap.set("n", "[i", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.INFO })
end, { desc = "Prev info" })

vim.keymap.set("n", "]h", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
end, { desc = "Next hint" })

vim.keymap.set("n", "[h", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT })
end, { desc = "Prev hint" })

vim.keymap.set("n", "<leader>ls", function()
	require("persistence").load()
end, { desc = "Restore last session" })

vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })

vim.keymap.set("n", "<leader>fp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	vim.notify("Copied: " .. vim.fn.expand("%:p"), vim.log.levels.INFO)
end, { desc = "Copy file path" })

-- Toggle Neogit status window
vim.keymap.set("n", "<leader>ng", function()
	local neogit = require("neogit")
	local tabpage_list = vim.api.nvim_list_tabpages()
	local found = false

	-- Check if Neogit buffer already exists
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
		if bufname:match("NeogitStatus") then
			vim.api.nvim_win_close(win, true)
			found = true
			break
		end
	end

	if not found then
		neogit.open({ kind = "tab" }) -- options: "split", "vsplit", "tab"
	end
end, { desc = "Toggle Neogit" })

-- Enable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end

		local opts = { buffer = args.buf, silent = true }

		-- Go to definition
		vim.keymap.set("n", "gd", function()
			local params = vim.lsp.util.make_position_params()
			vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, ctx)
				if not result or vim.tbl_isempty(result) then
					vim.notify("[LSP] Definition not found", vim.log.levels.INFO)
					return
				end

				local client = vim.lsp.get_client_by_id(ctx.client_id)
				local location = result[1]

				-- The new preferred method
				vim.lsp.util.show_document(location, client.offset_encoding)
			end)
		end, opts)

		-- Optional: Go to declaration
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

		-- Go to references
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))

		-- Go to implementation
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

		-- Show hover docs
		vim.keymap.set("n", "E", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP hover documentation" }))
	end,
})
