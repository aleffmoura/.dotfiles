if not _G.plugin_loaded("mason-lspconfig.nvim") then
	do return end
end

local lsp_installer_ensure_installed = {
	-- LSP
	"bashls",
	"omnisharp",
	"cssls",
	"dockerls",
	"eslint",
	"html",
	"jsonls",
	"pyright",
	"tsserver",
	"sumneko_lua",
	"marksman",
	--"sqls", -- https://github.com/lighttiger2505/sqls
	"lemminx",
	"yamlls",

	-- DAP
	-- "netcoredbg",

	-- LINTERS
	"tflint",

	-- FORMATTERS
	-- "csharpier",
	-- "jq",
	-- "markdownlint",
	-- "prettier"
}

if vim.fn.has("win32") == 1 then
	table.insert(lsp_installer_ensure_installed, "powershell_es")
elseif vim.fn.has("unix") == 1 then 
	-- table.insert(lsp_installer_ensure_installed, "omnisharp_mono")
end


require("mason-lspconfig").setup({
	ensure_installed = lsp_installer_ensure_installed
})