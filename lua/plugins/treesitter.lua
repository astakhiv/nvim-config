return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function ()
	local configs = require("nvim-treesitter")

	configs.install({"lua", "go", "c", "cpp"})
    end
}
