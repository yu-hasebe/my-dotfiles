return {
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.10.0",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "go", "lua" },
				highlight = {
					enable = true,
				},
			})
		end,
	},
}
