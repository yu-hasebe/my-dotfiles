require("helpers.user_command")
require("helpers.auto_command")
require("helpers.lsp")

vim.o.encoding = "utf-8"
vim.o.number = true
vim.o.relativenumber = true

-- Indent
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Scroll offset
vim.o.scrolloff = 3

-- Move the cursor to the next (previous) line across the last (first) character
vim.o.whichwrap = "b,s,h,l,<,>,[,],~"

-- Share clipboard with OS
vim.o.clipboard = "unnamedplus"

-- Show cursorline
vim.o.cursorline = true

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
})

-- Type gx to jump this page:
-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(event)
		local dir = vim.fs.dirname(event.file)
		local force = vim.v.cmdbang == 1
		local isdirectory = vim.fn.isdirectory(dir) == 0
		if isdirectory and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', "&Yes\n&No") == 1) then
			vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), "p")
		end
	end,
	desc = "Auto mkdir to save files",
})

require("helpers.mini")
require("helpers.lazy")

vim.cmd.colorscheme("kanagawa")
vim.opt.laststatus = 3
vim.opt.cmdheight = 0

