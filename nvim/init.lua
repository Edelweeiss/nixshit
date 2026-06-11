vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/Saghen/blink.lib" }
})

vim.lsp.enable({"lua_ls", "clangd", "rust_analyzer"})

require('blink.cmp').setup({
  fuzzy = {
    implementation = "lua",
  }
})
require("telescope").setup({
	defaults = {
		preview = {
			treesitter = false,
		},
	},
})
require "mason".setup()
require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>g', builtin.live_grep)
vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>')
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>fd", function()
	builtin.lsp_definitions()
end, { desc = "Definitions (Telescope)" })

vim.keymap.set("n", "<leader>fr", function()
	builtin.lsp_references()
end, { desc = "References (Telescope)" })

vim.keymap.set("n", "<leader>fi", function()
	builtin.lsp_implementations()
end, { desc = "Implementations (Telescope)" })

vim.keymap.set("n", "<leader>fs", function()
	builtin.lsp_document_symbols()
end, { desc = "Document symbols" })

vim.keymap.set("n", "<leader>fS", function()
	builtin.lsp_workspace_symbols()
end, { desc = "Workspace symbols" })

require('vague').setup({
	colors = {
		bg = '#000000'
	}
})
vim.cmd("colorscheme vague")
