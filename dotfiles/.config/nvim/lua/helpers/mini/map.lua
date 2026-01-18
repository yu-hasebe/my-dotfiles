--
-- MAP
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/522fce
--

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-map.md
local map = require("mini.map")
map.setup({
	integrations = {
		map.gen_integration.builtin_search(),
		map.gen_integration.diff(),
		map.gen_integration.diagnostic(),
	},
	symbols = {
		scroll_line = "▶",
	},
})
vim.keymap.set("n", "mmf", MiniMap.toggle_focus, { desc = "MiniMap.toggle_focus" })
vim.keymap.set("n", "mms", MiniMap.toggle_side, { desc = "MiniMap.toggle_side" })
vim.keymap.set("n", "mmt", MiniMap.toggle, { desc = "MiniMap.toggle" })
