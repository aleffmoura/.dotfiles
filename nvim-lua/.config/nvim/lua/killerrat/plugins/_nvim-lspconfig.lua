if not _G.plugin_loaded("nvim-lspconfig") then
	print("nvim-lspconfig not loaded")
	do return end
end

require'lspconfig'.bashls.setup{}

-- EXAMPLE OF TAKING INPUT,
-- FROM: https://github.com/neovim/nvim-lspconfig/issues/2108#issuecomment-1236248592
-- local fname = vim.fn.input("File: ", "", "file")
-- confirm(text[,choices[,default[,type]]])

-- BEGGININGS OF LOADING .NET FRAMEWORK OR .NET 6 OMNISHARP CONDITIONALLY
-- lspconfig.csharp_ls.autostart({
--   autostart = false
-- }

-- lspconfig.omnisharp.autostart({
--   autostart = false
-- }
-- then

-- vim.api.nvim_create_autocmd("FileType",{
--   pattern = 'csharp',
--   callback = function()
--     -- check the cspj or something else to confirm it's .net framework or .net core project
--    if is_netcore then
--        vim.cmd('LspStart  omnisharp')
--         return
--    end
--    vim.cmd('LspStart csharp_ls')
--   end
-- }

-- EXAMPLE OF HOW YOU CAN TRAVERSE A DIRECTORY USING A GLOB, FROM:
-- https://www.reddit.com/r/neovim/comments/rsrmux/source_all_files_in_a_directory_using_lua_script/
-- local paths = vim.split(vim.fn.glob('~/.config/nvim/lua/*/*lua'), '\n'),
-- for i, file in pairs(paths) do
--   vim.cmd('source ' .. file)
-- end

-- /BEGGININGS OF LOADING .NET FRAMEWORK OR .NET 6 OMNISHARP CONDITIONALLY

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
require'lspconfig'.omnisharp.setup {
	-- use_mono = true
	-- environment = "netframework"
	-- environment = "dotnet"
	organize_imports_on_format = true,
}

require'lspconfig'.cssls.setup {
	capabilities = capabilities,
}

require'lspconfig'.dockerls.setup{}

-- ESLINT
--- npm i -g vscode-langservers-extracted
-- require'lspconfig'.eslint.setup {}
-- npm i -g eslint
local eslint_config = require("lspconfig.server_configurations.eslint")
require'lspconfig'.eslint.setup {
    -- opts.cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

require'lspconfig'.jsonls.setup {
	capabilities = capabilities,
}

require'lspconfig'.pyright.setup{}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.sumneko_lua.setup{}

require'lspconfig'.marksman.setup{}

require'lspconfig'.lemminx.setup{}

-- ADD MODELINE TO FILES:
-- # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>
require'lspconfig'.yamlls.setup{}

-- POWERSHELL
-- TODO:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#powershell_es
if vim.fn.has('win32') == 1 then
	require'lspconfig'.powershell_es.setup{}
end

require'lspconfig'.tflint.setup{}







