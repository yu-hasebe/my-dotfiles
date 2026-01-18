-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-icons.md
require("mini.icons").setup()

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-statusline.md
require("mini.statusline").setup()

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-extra.md
local hi_words = require("mini.extra").gen_highlighter.words
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-hipatterns.md
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', TODO', 'NOTE'
		fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
		todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
		note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

-- FIXME: Why not work?
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-cursorword.md
require("mini.cursorword").setup()

-- Show a vertical line to clarify indent
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-indentscope.md
require("mini.indentscope").setup()

-- Show unnecessary trail spaces
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-trailspace.md
require("mini.trailspace").setup()

-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-starter.md
require("mini.starter").setup()

-- Auto completion of two 'paired' characters such as ()
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md
require("mini.pairs").setup()

-- 'surround' operators such as 'sa'
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md
require("mini.surround").setup()

-- Convenience motions such as 'iJ'
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-ai.md
local gen_ai_spec = require("mini.extra").gen_ai_spec
require("mini.ai").setup({
	custom_textobjects = {
		B = gen_ai_spec.buffer(),
		D = gen_ai_spec.diagnostic(),
		I = gen_ai_spec.indent(),
		L = gen_ai_spec.line(),
		N = gen_ai_spec.number(),
		J = { { "()%d%d%d%d%-%d%d%-%d%d()", "()%d%d%d%d%/%d%d%/%d%d()" } },
	},
})

-- Show a dynamic help message of custom key mappings
-- https://zenn.dev/kawarimidoll/books/6064bf6f193b51/viewer/ec6109
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-clue.md
-- NOTE: Add the first letter of custom keys that you'd like to need a help message of, to triggers
local function mode_nx(keys)
	return { mode = "n", keys = keys }, { mode = "x", keys = keys }
end
local clue = require("mini.clue")
clue.setup({
	triggers = {
		-- Leader triggers
		mode_nx("<leader>"),

		-- Built-in completion
		{ mode = "i", keys = "<c-x>" },

		-- `g` key
		mode_nx("g"),

		-- Marks
		mode_nx("'"),
		mode_nx("`"),

		-- Registers
		mode_nx('"'),
		{ mode = "i", keys = "<c-r>" },
		{ mode = "c", keys = "<c-r>" },

		-- Window commands
		{ mode = "n", keys = "<c-w>" },

		-- bracketed commands
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },

		-- `z` key
		mode_nx("z"),

		-- surround
		mode_nx("s"),

		-- text object
		{ mode = "x", keys = "i" },
		{ mode = "x", keys = "a" },
		{ mode = "o", keys = "i" },
		{ mode = "o", keys = "a" },

		-- option toggle (mini.basics)
		{ mode = "n", keys = "m" },
	},

	clues = {
		-- Enhance this by adding descriptions for <Leader> mapping groups
		clue.gen_clues.builtin_completion(),
		clue.gen_clues.g(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers({ show_contents = true }),
		clue.gen_clues.windows({ submode_resize = true, submode_move = true }),
		clue.gen_clues.z(),
	},
})

local dirname = vim.fn.stdpath('config') .. '/lua/helpers/mini'

for file, ftype in vim.fs.dir(dirname) do
  if ftype == 'file' and vim.endswith(file, '.lua') and file ~= 'init.lua' then
    local name = file:sub(1, -5)
    local ok, result = pcall(require, 'helpers.mini.' .. name)
    if not ok then
      vim.notify('Error loading a mini helper: ' .. name .. '\n' .. result, vim.log.levels.WARN)
    end
  end
end
