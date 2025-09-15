local map = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = true
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Easy command-line mode
map("", ";", ":")

-- Easier bracket matching
map("", "<Tab>", "%", { remap = true })
map("", "<C-o>", "<Nop>")

-- Quit
map("i", "<c-q>", "<esc>:q<cr>")
map("n", "<c-q>", ":q<cr>")

-- Save
map("i", "<C-s>", "<C-o>:update<cr>")
map("n", "<C-s>", ":update<cr>")

-- Split windows
map("n", "<leader>s", "<C-W>s")
map("n", "<leader>v", "<C-W>v")

-- Easier to type, and I never use the default behavior.
map({ "n", "x", "o" }, "H", "^")
map({ "n", "o" }, "L", "$")
map("x", "L", "g_")

-- No overwrite paste
map("x", "p", [["_dP]])

-- Reindent entire file
map("n", "==", [[mqHmwgg=G`wzt`q]])

-- Easy filetype switching
map("n", "=f", ":setfiletype<Space>")

-- Open notes directory
map("n", "<leader>n", ":tabedit /mnt/c/Users/Rainer\\ Borene/Dropbox/Notebook/Notes<cr>")

-- Fast escape from insert mode
map("i", "jj", "<esc>", { remap = true })

-- Faster scrolling
map("n", "<c-e>", "5<c-e>")
map("n", "<c-y>", "5<c-y>")

-- Remap for dealing with word wrap and adding jumps to the jumplist.
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Keeping the cursor centered.
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Center screen
map("n", "gg", "ggzz")
map("n", "G", "Gzz")

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

-- Same when moving up and down
map("", "<C-d>", "<C-d>zz")
map("", "<C-u>", "<C-u>zz")

-- Use c-\ to do c-] but open it in a new split.
map("n", "<c-]>", "<c-]>zz")
map("n", "<c-\\>", ":vertical wincmd ]<cr>zz")

-- `gf` opens file under cursor in a new vertical split
map("c", "<Plug><cfile>", "<C-R><C-F>")
map("n", "gf", ":vert sfind <Plug><cfile><CR>")

-- [w ]w - Forward and backwards tabs
map("n", "[w", "<esc>:tabprevious<cr>")
map("n", "]w", "<esc>:tabnext<cr>")

-- [W ]W - Move tabs
map("n", "[W", "<esc>:tabmove -1<cr>")
map("n", "]W", "<esc>:tabmove +1<cr>")

-- Space to toggle folds.
map({ "n", "v" }, "<Space>", "za")

-- Ctrl-b: Go (b)ack. Go to previously buffer
map("n", "<c-b>", "<c-^>")

-- Do NOT yank with x/s
map("", "x", [["_x]])
map("", "X", [["_d]])
map("n", "s", [["_s]])
map("n", "S", [["_S]])

-- Clean trailing whitespace
map("n", "=w", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.api.nvim_win_set_cursor(0, curpos)
end)

-- Select last paste
map({ "x", "o" }, "gp", function()
  local mode = vim.fn.mode()
  local is_visual = mode == "v" or mode == "V" or mode == "\22"

  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "["))
  vim.cmd.normal { is_visual and "o" or "v", bang = true }
  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "]"))
end)

-- Close quickfix/location window
map("n", "<leader>c", function()
  local nr = vim.fn.winnr "$"
  if #vim.fn.getqflist() > 0 then
    vim.cmd.copen()
  end
  if nr == vim.fn.winnr "$" then
    vim.cmd.cclose()
  end
end)

-- Poweful <esc>.
map({ "i", "s", "n" }, "<esc>", function()
  vim.snippet.stop()
  return "<esc>"
end, { expr = true })
