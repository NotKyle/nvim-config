return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = vim.fs.root(0, { ".luarc.json", ".luarc.jsonc", ".git" }),
}
