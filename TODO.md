# init.lua Cleanup TODO

Recommendations from code review of `init.lua`. All line numbers reference the file as of 2026-06-28.

---

## High Priority

### 1. Fix `<leader>w` keymap collision
- **Files:** `init.lua:112`, `init.lua:252`
- `<leader>w` is bound to `:w<CR>` (save file) AND declared as the `[W]orkspace` which-key group.
- The save binding wins, so which-key shows "Save file" instead of the workspace group — confusing.
- **Fix:** Remap save to something like `<leader>fs`, or remove the `[W]orkspace` group entry from the which-key spec (line 252).

### 2. Replace deprecated `vim.lsp.buf_request_sync` in Go autocmd
- **File:** `init.lua:1175-1194`
- `vim.lsp.buf_request_sync` is deprecated as of Neovim 0.10+ and may break on 0.11+.
- The entire `setGoFormatting` autocmd block handles organize-imports for Go.
- **Fix:** Delete the autocmd block and add `goimports` to conform's `formatters_by_ft`:
  ```lua
  go = { "goimports" },
  ```
  `goimports` handles both import organization and formatting in one pass. Make sure `goimports` is in Mason's `ensure_installed` list too.

### 3. Neo-tree should toggle, not just open
- **File:** `init.lua:887`
- Current: `":Neotree<CR>"` — opens the tree but pressing `<leader>e` again does nothing.
- **Fix:**
  ```lua
  vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })
  ```

---

## Medium Priority

### 4. Remove unnecessary Neogit dependencies
- **File:** `init.lua:1083-1091`
- Neogit lists `fzf-lua` and `mini.pick` as optional picker dependencies. Telescope is already installed and sufficient.
- **Fix:** Remove these two lines from neogit's dependencies:
  ```lua
  "ibhagwan/fzf-lua",
  "echasnovski/mini.pick",
  ```

### 5. Resolve `foldenable`/`foldlevel` redundancy
- **File:** `init.lua:122-123`
- `foldenable = false` disables all folds; `foldlevel = 99` has no effect when folding is disabled.
- **Fix:** Pick one intent:
  - Never want folds → keep `foldenable = false`, delete `foldlevel = 99`
  - Want folds open by default → set `foldenable = true`, keep `foldlevel = 99`

### 6. Add `linebreak` when `wrap` is enabled
- **File:** `init.lua:121`
- `wrap = true` breaks lines at the window edge, potentially mid-word.
- **Fix:** Add:
  ```lua
  vim.opt.linebreak = true
  ```

### 7. Add `"go"` to treesitter `ensure_installed`
- **File:** `init.lua:845-857`
- Go is used (gopls + nvim-dap-go configured) but absent from the explicit parser list.
- `auto_install = true` covers it lazily but causes a delay on first open.
- **Fix:** Add `"go"` to the `ensure_installed` table.

---

## Low Priority

### 9. Register harpoon and neo-tree keymaps in which-key
- **File:** `init.lua:247-255` (which-key spec)
- `<leader>a` (harpoon add), `<leader>1-4` (harpoon slots), and `<leader>e` (neo-tree) are not registered in the which-key spec.
- **Fix:** Add entries to the `spec` table so they appear in the popup.

### 10. Strip kickstart boilerplate comments
- The file has ~100 lines of tutorial-style comments inherited from kickstart.nvim (LSP explainers, Telescope usage tips, etc.).
- Safe to remove now that the config is stable. Reduces file length significantly.
