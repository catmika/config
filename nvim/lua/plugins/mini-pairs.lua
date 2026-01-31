-- 𓊆 𓊇 𓊈 𓊉 𓉘 𓉝 Pairs: Automatic adding and deletion of closing surrounding character
return {
	"nvim-mini/mini.pairs",
	version = "*",
	config = function()
		require("mini.pairs").setup()
	end,
}
