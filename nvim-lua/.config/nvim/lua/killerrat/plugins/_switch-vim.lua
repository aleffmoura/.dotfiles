if not _G.plugin_loaded("switch.vim") then
	print("Switch not found, not loading")
	do return end
end

-- " FROM: https://github.com/AndrewRadev/switch.vim
-- " keybinding is gs

vim.cmd[[let g:switch_custom_definitions =
    \ [
    \   switch#NormalizedCaseWords(['private', 'protected', 'internal', 'public']),
    \   switch#NormalizedCaseWords(['true', 'false']),
    \   switch#NormalizedCaseWords(['before', 'after']),
    \   switch#NormalizedCaseWords(['to', 'from']),
    \   switch#NormalizedCaseWords(['==', '!=']),
    \   switch#NormalizedCaseWords(['min', 'max']),
    \   switch#NormalizedCaseWords(['UAT', 'PROD']),
		\   switch#NormalizedCaseWords(['starting', 'stopping']),
    \   switch#NormalizedCaseWords(['start', 'stop']),
    \ ]
]]

