local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
return {
    {
	"rebelot/kanagawa.nvim",
	opts = {
	    transparent = true,

	},
	config = function(_, opts)
	    require("kanagawa").setup(opts)
	    vim.cmd.colorscheme "kanagawa-wave"
	end
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    options = {
		theme = 'iceberg_dark',
		section_separators = { left = '|', right = '|' },
		component_separators = { left = '|', right = '|' }
	    },
	}
    },
}

