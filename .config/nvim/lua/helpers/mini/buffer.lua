--
-- BUFFER
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/c28792
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/88be07
--

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-tabline.md
require("mini.tabline").setup()
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-bufremove.md
require("mini.bufremove").setup()

vim.api.nvim_create_user_command("Bufdelete", function()
	MiniBufremove.delete()
end, { desc = "Remove buffer" })

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-files.md
require("mini.files").setup()

vim.api.nvim_create_user_command("Files", function()
	MiniFiles.open()
end, { desc = "Open file exproler" })

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pick.md
require("mini.pick").setup()
vim.ui.select = MiniPick.ui_select
vim.keymap.set("n", "<space>f", function()
	MiniPick.builtin.files({ tool = "git" })
end, { desc = "mini.pick.files" })

vim.keymap.set("n", "<space>b", function()
	local wipeout_cur = function()
		vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
	end
	local buffer_mappings = { wipeout = { char = "<c-d>", func = wipeout_cur } }
	MiniPick.builtin.buffers({ include_current = false }, { mappings = buffer_mappings })
end, { desc = "mini.pick.buffers" })

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-visits.md
require("mini.visits").setup()
vim.keymap.set("n", "<space>h", function()
	require("mini.extra").pickers.visit_paths()
end, { desc = "mini.extra.visit_paths" })

vim.keymap.set("c", "h", function()
	if vim.fn.getcmdtype() .. vim.fn.getcmdline() == ":h" then
		return "<c-u>Pick help<cr>"
	end
	return "h"
end, { expr = true, desc = "mini.pick.help" })
