return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			{
				"nvim-treesitter/nvim-treesitter", -- Optional, but recommended
				branch = "main", -- NOTE; not the master branch!
				build = function()
					vim.cmd(":TSUpdate go")
				end,
			},
			{
				"fredrikaverpil/neotest-golang",
				version = "*", -- Optional, but recommended; track releases
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
				end,
			},
		},
		config = function()
			local config = {
				runner = "gotestsum", -- Optional, but recommended
			}
			require("neotest").setup({
				adapters = {
					require("neotest-golang")(config),
				},
			})
			vim.keymap.set("n", "<leader>td", function()
				require("neotest").run.run(vim.fn.getcwd())
			end, { desc = "Run File Tests" })
			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "Run File Tests" })
			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "Toggle Test Summary" })
		end,
	},
}
