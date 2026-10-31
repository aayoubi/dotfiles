-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
-- 	vim.opt.clipboard = "unnamedplus"
-- end)

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", ":q!<CR>", { desc = "Force quit" })
vim.keymap.set("n", "<leader>z", ":wq<CR>", { desc = "Save and quit" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>n", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>N", ":bprev<CR>", { desc = "Prev buffer" })
vim.keymap.set("i", "jj", "<ESC>")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.foldenable = false

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Plugins: managed with the built-in `vim.pack` (Neovim 0.12+) ]]
--    :lua vim.pack.update()  review/apply updates
--    :lua vim.pack.del({ "name" })  remove a plugin
--    Lockfile: nvim-pack-lock.json (next to this config)
if vim.fn.has("nvim-0.12") == 0 then
	vim.notify("vim.pack needs Neovim 0.12+; plugins not loaded", vim.log.levels.WARN)
	return
end

-- Build steps. Registered BEFORE vim.pack.add so first-time installs run them.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("pack-build-hooks", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if kind ~= "install" and kind ~= "update" then
			return
		end
		if name == "nvim-treesitter" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		elseif vim.fn.executable("make") == 1 then
			local target = ({
				["telescope-fzf-native.nvim"] = "make",
				["LuaSnip"] = "make install_jsregexp",
			})[name]
			if target then
				vim.system(vim.split(target, " "), { cwd = ev.data.path }):wait()
			end
		end
	end,
})

local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	-- libraries
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/snacks.nvim"),
	gh("sindrets/diffview.nvim"),

	-- editing
	gh("tpope/vim-sleuth"),
	gh("echasnovski/mini.nvim"),
	gh("folke/todo-comments.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("folke/which-key.nvim"),
	gh("folke/tokyonight.nvim"),
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },

	-- navigation
	{ src = gh("nvim-telescope/telescope.nvim"), version = "0.1.x" },
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
	{ src = gh("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },
	{ src = gh("ThePrimeagen/harpoon"), version = "harpoon2" },

	-- LSP, completion, formatting (order: mason before mason-lspconfig)
	gh("williamboman/mason.nvim"),
	gh("williamboman/mason-lspconfig.nvim"),
	gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("j-hui/fidget.nvim"),
	gh("folke/lazydev.nvim"),
	gh("Bilal2453/luvit-meta"),
	gh("stevearc/conform.nvim"),
	gh("L3MON4D3/LuaSnip"),
	gh("saadparwaiz1/cmp_luasnip"),
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("hrsh7th/cmp-path"),
	gh("hrsh7th/nvim-cmp"),

	-- git / AI
	gh("NeogitOrg/neogit"),
	gh("coder/claudecode.nvim"),
})

-- Local dev plugin (previously ~/.config/nvim/lua/plugins/dev.lua)
local present = vim.fn.expand("~/plugins/present.nvim")
if vim.uv.fs_stat(present) then
	vim.opt.rtp:append(present)
	pcall(require, "present")
end

-- Colorscheme
vim.cmd.colorscheme("tokyonight-night")
vim.cmd.hi("Comment gui=none")

-- Simple setups
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
require("todo-comments").setup({ signs = false })
require("fidget").setup({})
require("neogit").setup({})
require("claudecode").setup({})

-- which-key
require("which-key").setup({
	icons = {
		mappings = vim.g.have_nerd_font,
		keys = vim.g.have_nerd_font and {} or {
			Up = "<Up> ",
			Down = "<Down> ",
			Left = "<Left> ",
			Right = "<Right> ",
			C = "<C-…> ",
			M = "<M-…> ",
			D = "<D-…> ",
			S = "<S-…> ",
			CR = "<CR> ",
			Esc = "<Esc> ",
			ScrollWheelDown = "<ScrollWheelDown> ",
			ScrollWheelUp = "<ScrollWheelUp> ",
			NL = "<NL> ",
			BS = "<BS> ",
			Space = "<Space> ",
			Tab = "<Tab> ",
			F1 = "<F1>",
			F2 = "<F2>",
			F3 = "<F3>",
			F4 = "<F4>",
			F5 = "<F5>",
			F6 = "<F6>",
			F7 = "<F7>",
			F8 = "<F8>",
			F9 = "<F9>",
			F10 = "<F10>",
			F11 = "<F11>",
			F12 = "<F12>",
		},
	},
	spec = {
		{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
	},
})

-- Telescope
do
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})

	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "ui-select")

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
	vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

	vim.keymap.set("n", "<leader>/", function()
		builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
			winblend = 10,
			previewer = false,
		}))
	end, { desc = "[/] Fuzzily search in current buffer" })

	vim.keymap.set("n", "<leader>s/", function()
		builtin.live_grep({
			grep_open_files = true,
			prompt_title = "Live Grep in Open Files",
		})
	end, { desc = "[S]earch [/] in Open Files" })

	vim.keymap.set("n", "<leader>sn", function()
		builtin.find_files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim files" })
end

-- LSP
require("lazydev").setup({
	library = {
		-- Load luvit types when the `vim.uv` word is found
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})
do
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
			map(
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				"[W]orkspace [S]ymbols"
			)

			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup =
					vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	local servers = {
		gopls = {},

		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		},
	}

	require("mason").setup()

	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua",
		"goimports",
		"tree-sitter-cli", -- nvim-treesitter (main) builds parsers with it
	})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

-- Autoformat
vim.keymap.set("", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })
require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		-- Disable "format_on_save lsp_fallback" for languages that don't
		-- have a well standardized coding style. You can add additional
		-- languages here or re-enable it for the disabled ones.
		local disable_filetypes = { c = true, cpp = true }
		local lsp_format_opt
		if disable_filetypes[vim.bo[bufnr].filetype] then
			lsp_format_opt = "never"
		else
			lsp_format_opt = "fallback"
		end
		return {
			timeout_ms = 500,
			lsp_format = lsp_format_opt,
		}
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports" },
	},
})

-- Autocompletion
do
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		completion = { completeopt = "menu,menuone,noinsert" },

		-- For an understanding of why these mappings were
		-- chosen, you will need to read `:help ins-completion`
		--
		-- No, but seriously. Please read `:help ins-completion`, it is really good!
		mapping = cmp.mapping.preset.insert({
			-- Select the [n]ext item
			["<C-n>"] = cmp.mapping.select_next_item(),
			-- Select the [p]revious item
			["<C-p>"] = cmp.mapping.select_prev_item(),

			-- Scroll the documentation window [b]ack / [f]orward
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),

			-- Accept ([y]es) the completion.
			--  This will auto-import if your LSP supports it.
			--  This will expand snippets if the LSP sent a snippet.
			["<C-y>"] = cmp.mapping.confirm({ select = true }),

			-- If you prefer more traditional completion keymaps,
			-- you can uncomment the following lines
			--['<CR>'] = cmp.mapping.confirm { select = true },
			--['<Tab>'] = cmp.mapping.select_next_item(),
			--['<S-Tab>'] = cmp.mapping.select_prev_item(),

			["<C-Space>"] = cmp.mapping.complete({}),
			["<C-l>"] = cmp.mapping(function()
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { "i", "s" }),
			["<C-h>"] = cmp.mapping(function()
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { "i", "s" }),
		}),
		sources = {
			{
				name = "lazydev",
				-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
				group_index = 0,
			},
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
		},
	})
end

-- mini.nvim
do
	require("mini.ai").setup({ n_lines = 500 })
	require("mini.surround").setup()

	local statusline = require("mini.statusline")
	statusline.setup({ use_icons = vim.g.have_nerd_font })
	---@diagnostic disable-next-line: duplicate-set-field
	statusline.section_location = function()
		return "%2l:%-2v"
	end
end

-- Treesitter (main branch: explicit install + per-filetype start)
do
	local ensure_installed = {
		"bash", "c", "diff", "go", "html", "lua", "luadoc", "markdown", "markdown_inline",
		"query", "vim", "vimdoc", "python", "typescript", "javascript",
	}
	local installed = require("nvim-treesitter.config").get_installed()
	local missing = vim.iter(ensure_installed)
		:filter(function(p)
			return not vim.tbl_contains(installed, p)
		end)
		:totable()
	if #missing > 0 then
		require("nvim-treesitter").install(missing)
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
		callback = function(args)
			if pcall(vim.treesitter.start, args.buf) then
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end,
	})
end

-- neo-tree
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true, desc = "Toggle file explorer" })

-- harpoon
do
	local harpoon = require("harpoon")
	harpoon:setup()
	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end, { desc = "Add buffer to harpoon" })
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Harpoon quick menu" })
	vim.keymap.set("n", "<leader>1", function()
		harpoon:list():select(1)
	end, { desc = "Harpoon slot 1" })
	vim.keymap.set("n", "<leader>2", function()
		harpoon:list():select(2)
	end, { desc = "Harpoon slot 2" })
	vim.keymap.set("n", "<leader>3", function()
		harpoon:list():select(3)
	end, { desc = "Harpoon slot 3" })
	vim.keymap.set("n", "<leader>4", function()
		harpoon:list():select(4)
	end, { desc = "Harpoon slot 4" })
end

-- claudecode keymaps
do
	local map = function(lhs, rhs, desc, mode)
		vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
	end
	map("<leader>ct", "<cmd>ClaudeCode<cr>", "Toggle Claude")
	map("<leader>cf", "<cmd>ClaudeCodeFocus<cr>", "Focus Claude")
	map("<leader>cr", "<cmd>ClaudeCode --resume<cr>", "Resume Claude")
	map("<leader>cC", "<cmd>ClaudeCode --continue<cr>", "Continue Claude")
	map("<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", "Select Claude model")
	map("<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", "Add current buffer")
	map("<leader>cs", "<cmd>ClaudeCodeSend<cr>", "Send to Claude", "v")
	-- Diff management
	map("<leader>da", "<cmd>ClaudeCodeDiffAccept<cr>", "Accept diff")
	map("<leader>dd", "<cmd>ClaudeCodeDiffDeny<cr>", "Deny diff")
	-- In file explorers, <leader>cs adds the file under the cursor
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		callback = function(args)
			vim.keymap.set("n", "<leader>cs", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = args.buf, desc = "Add file" })
		end,
	})
end

-- vim: ts=2 sts=2 sw=2 et
