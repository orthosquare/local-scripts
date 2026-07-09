vim.pack.add({
  { src = "https://github.com/reblot/kanagawa.nvim" },
})

require("kanagawa").setup({
	compile = true, -- enable compiling the colorscheme
	transparent = true, -- Remove the background
	overrides = function(colors)
		return {
			["@markup.link.url.markdown_inline"] = { link = "Special" },
			["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
			["@markup.italic.markdown_inline"] = { link = "Exception" },
			["@markup.raw.markdown_inline"] = { link = "String" },
			["@markup.list.markdown"] = { link = "Function" },
			["@markup.quote.markdown"] = { link = "Error" },
			["@markup.list.checked.markdown"] = { link = "WarningMsg" },
		}
	end,
})


require("kanagawa").load("wave")
