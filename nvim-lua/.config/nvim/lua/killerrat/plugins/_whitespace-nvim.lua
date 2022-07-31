-- If plugin is not loaded (e.g. disabled), skip this file!
if not _G.plugin_loaded("whitespace-nvim") then
	do return end
end

require('whitespace-nvim').setup({
	-- configuration options and their defaults

	-- `highlight` configures which highlight is used to display
	-- trailing whitespace
	highlight = 'DiffDelete'

	-- `ignored_filetypes` configures which filetypes to ignore when
	-- displaying trailing whitespace
	ignored_filetypes = { 'TelescopePrompt' },
})

-- remove trailing whitespace with a keybinding
-- vim.api.nvim_set_keymap(
-- 	'n',
-- 	'<Leader>t',
-- 	[[<cmd>lua require('whitespace-nvim').trim()<CR>]]
-- 	{ noremap = true }
-- )

