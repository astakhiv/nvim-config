return {
	"saghen/blink.cmp",
	build = function()
		require("blink.cmp").build():pwait()
	end,
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},

	opts = {
		keymap = {
			preset = "default",
			["<S-Enter>"] = { "select_and_accept" },
		},

		completion = { documentation = { auto_show = true } },

		sources = { default = { "lsp", "path", "snippets", "buffer" } },
	},
}
