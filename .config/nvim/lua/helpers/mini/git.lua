--
-- GIT
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/2b40eb
--

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-diff.md
require("mini.diff").setup()

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-git.md
require("mini.git").setup()
vim.keymap.set({ "n", "x" }, "<space>gs", MiniGit.show_at_cursor, { desc = "Show at cursor" })
