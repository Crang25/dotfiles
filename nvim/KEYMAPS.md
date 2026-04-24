# Neovim Essential Keymaps

`<leader>` is set to `Space`.

This document focuses on everyday workflows: finding code, editing quickly, navigating diagnostics, working with git hunks, and managing tabs/buffers.

## Core Editing

| Key | Mode | Action | How to use |
|---|---|---|---|
| `<C-s>` | Normal | Save file | Press any time to write current buffer. |
| `jk` | Insert | Exit to Normal mode | Type quickly in insert mode to avoid reaching for `Esc`. |
| `<leader>h` | Normal | Clear search highlight | Use after `/` search when highlights are noisy. |

## Files, Search, and Replace

| Key | Mode | Action | How to use |
|---|---|---|---|
| `<C-p>` | Normal | Find files (Telescope) | Fuzzy-search files in project. |
| `<leader>fg` | Normal | Live grep (Telescope) | Search text across project. |
| `<leader><leader>` | Normal | Recent files (Telescope) | Jump back to recently opened files. |
| `<leader>b` | Normal | Open buffers (Telescope) | Switch quickly between open buffers. |
| `<leader>sr` | Normal | Project search/replace (Spectre) | Open replace panel for full-project changes. |
| `<leader>sr` | Visual | Search selected text (Spectre) | Select text first, then search/replace across project. |
| `<leader>sw` | Normal | Search current word (Spectre) | Cursor on a symbol, then search/replace that symbol globally. |
| `<leader>sf` | Normal | Search/replace current file (Spectre) | Safer replace scope inside current file. |

## Buffer and Tab Management

| Key | Mode | Action | How to use |
|---|---|---|---|
| `<S-l>` / `<leader>bn` | Normal | Next buffer | Move to next open buffer. |
| `<S-h>` / `<leader>bp` | Normal | Previous buffer | Move to previous open buffer. |
| `<leader>bd` | Normal | Delete current buffer | Close buffer without closing Neovim. |
| `<leader>tn` | Normal | New tab | Open a new tab page. |
| `<leader>tx` | Normal | Close tab | Close current tab page. |
| `<leader>to` | Normal | Keep only current tab | Close all other tabs. |
| `<leader>tl` / `]t` | Normal | Next tab | Move right through tabs. |
| `<leader>th` / `[t` | Normal | Previous tab | Move left through tabs. |

## Window and Pane Navigation

| Key | Mode | Action | How to use |
|---|---|---|---|
| `<C-Up>` / `<C-Down>` | Normal | Resize split height | Make current split taller/shorter. |
| `<C-Left>` / `<C-Right>` | Normal | Resize split width | Make current split narrower/wider. |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | Normal | Move between tmux/vim panes | Seamless pane navigation with tmux. |

## Git (Gitsigns)

| Key | Mode | Action | How to use |
|---|---|---|---|
| `]h` / `[h` | Normal | Next/prev git hunk | Jump between changed hunks in current file. |
| `<leader>gp` | Normal | Preview hunk | Show patch for current hunk before acting. |
| `<leader>gr` | Normal | Reset hunk | Discard changes in current hunk. |
| `<leader>gr` | Visual | Reset selected hunks | Select lines and discard only that range. |
| `<leader>gt` | Normal | Toggle line blame | Show/hide commit blame info on current line. |

## LSP Navigation and Refactors

Available only when an LSP is attached to the current buffer.

| Key | Mode | Action | How to use |
|---|---|---|---|
| `K` | Normal | Hover docs | Show symbol documentation under cursor. |
| `gd` | Normal | Go to definition | Jump to definition. |
| `gD` | Normal | Go to declaration | Jump to declaration (often interface/header level). |
| `<leader>k` | Normal | Signature help | Show function signature while editing calls. |
| `<leader>ca` | Normal/Visual | Code actions | Apply quick fixes/refactors. |
| `<leader>lr` | Normal | LSP references (Telescope) | List and jump to all references. |

## Diagnostics and Lists

| Key | Mode | Action | How to use |
|---|---|---|---|
| `]d` / `[d` | Normal | Next/prev diagnostic | Cycle errors/warnings in buffer. |
| `]q` / `[q` | Normal | Next/prev quickfix item | Navigate compiler/test/build results. |
| `]l` / `[l` | Normal | Next/prev location item | Navigate window-local result lists. |
| `<leader>xx` | Normal | Toggle diagnostics panel (Trouble) | Project diagnostics overview. |
| `<leader>xX` | Normal | Toggle buffer diagnostics (Trouble) | Diagnostics for current file only. |
| `<leader>cl` | Normal | Toggle LSP list (Trouble) | View definitions/references/implementations in side panel. |
| `<leader>cs` | Normal | Toggle symbols (Trouble) | Browse symbols in current buffer. |
| `<leader>xL` | Normal | Toggle location list (Trouble) | Inspect location list in panel view. |
| `<leader>xQ` | Normal | Toggle quickfix list (Trouble) | Inspect quickfix list in panel view. |

## Formatting and Terminal

| Key | Mode | Action | How to use |
|---|---|---|---|
| `<leader>gf` | Normal | Format current buffer | Uses configured formatter pipeline (none-ls preferred for many filetypes). |
| `<C-backtick>` | Normal | Toggle terminal | Open/close horizontal terminal. |
| `<leader>tc` | Terminal | Clear terminal output | Clears terminal screen from terminal mode. |
| `<leader>e` | Normal | Toggle file tree (Neo-tree) | Show/hide project tree. |

## Practical Daily Flow

1. Open files: `<C-p>`.
2. Search code globally: `<leader>fg`.
3. Refactor symbol: `gd`, then `<leader>ca` / `<leader>lr`.
4. Fix diagnostics: `]d` and `[d`, use `<leader>xx` for overview.
5. Format before commit: `<leader>gf`.
6. Review git changes per hunk: `]h`, `<leader>gp`, `<leader>gr`.
