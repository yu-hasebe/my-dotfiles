--
-- AUTO COMPLETION
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/c16b27
--

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-fuzzy.md
require("mini.fuzzy").setup()
-- Show auto completion
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-completion.md
require("mini.completion").setup({
	lsp_completion = {
		process_items = MiniFuzzy.process_lsp_items,
	},
})

-- improve fallback completion
vim.opt.complete = { ".", "w", "k", "b", "u" }
vim.opt.completeopt:append("fuzzy")
-- MacOS word dictionary
vim.opt.dictionary:append("/usr/share/dict/words")

-- define keycodes
local keys = {
	cn = vim.keycode("<c-n>"),
	cp = vim.keycode("<c-p>"),
	ct = vim.keycode("<c-t>"),
	cd = vim.keycode("<c-d>"),
	cr = vim.keycode("<cr>"),
	cy = vim.keycode("<c-y>"),
}

-- select by <tab>/<s-tab>
vim.keymap.set("i", "<tab>", function()
	-- popup is visible -> next item
	-- popup is NOT visible -> add indent
	return vim.fn.pumvisible() == 1 and keys.cn or keys.ct
end, { expr = true, desc = "Select next item if popup is visible" })
vim.keymap.set("i", "<s-tab>", function()
	-- popup is visible -> previous item
	-- popup is NOT visible -> remove indent
	return vim.fn.pumvisible() == 1 and keys.cp or keys.cd
end, { expr = true, desc = "Select previous item if popup is visible" })

-- complete by <cr>
vim.keymap.set("i", "<cr>", function()
	if vim.fn.pumvisible() == 0 then
		-- popup is NOT visible -> insert newline
		return require("mini.pairs").cr()
	end
	local item_selected = vim.fn.complete_info()["selected"] ~= -1
	if item_selected then
		-- popup is visible and item is selected -> complete item
		return keys.cy
	end
	-- popup is visible but item is NOT selected -> hide popup and insert newline
	return keys.cy .. keys.cr
end, { expr = true, desc = "Complete current item if item is selected" })

