return {
	"LunarVim/bigfile.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
	},
}
