vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Easy command-line mode
vim.keymap.set("", ";", ":")

-- Easier bracket matching
vim.keymap.set("", "<Tab>", "%", { remap = true })
vim.keymap.set("", "<C-o>", "<Nop>")

-- Quit
vim.keymap.set("i", "<c-q>", "<esc>:q<cr>")
vim.keymap.set("n", "<c-q>", ":q<cr>")

-- Save
vim.keymap.set("i", "<C-s>", "<C-o>:update<cr>")
vim.keymap.set("n", "<C-s>", ":update<cr>")

-- Split windows
vim.keymap.set("n", "<leader>s", "<C-W>s")
vim.keymap.set("n", "<leader>v", "<C-W>v")

-- Easier to type, and I never use the default behavior.
vim.keymap.set({ "n", "v", "o" }, "H", "^")
vim.keymap.set({ "n", "o" }, "L", "$")
vim.keymap.set("v", "L", "g_")

-- Fix issue with snippet expansion
vim.keymap.del("s", "H")
vim.keymap.del("s", "L")

-- No overwrite paste
vim.keymap.set("x", "p", [["_dP]])

-- Reindent entire file
vim.keymap.set("n", "==", [[mqHmwgg=G`wzt`q]])

-- Easy filetype switching
vim.keymap.set("n", "=f", ":setfiletype<Space>")

-- Open notes directory
vim.keymap.set("n", "<leader>n", ":tabedit /mnt/c/Users/Rainer\\ Borene/Dropbox/Notebook/Notes<cr>")

-- Insert Mode Completion
vim.keymap.set("i", "<c-j>", "<c-n>", { remap = true })
vim.keymap.set("i", "<c-k>", "<c-p>", { remap = true })
vim.keymap.set("i", "<c-c>", "<esc>", { remap = true })
vim.keymap.set("i", "jj", "<esc>", { remap = true })

-- Faster scrolling
vim.keymap.set("n", "<c-e>", "5<c-e>")
vim.keymap.set("n", "<c-y>", "5<c-y>")

-- Remap for dealing with word wrap and adding jumps to the jumplist.
vim.keymap.set("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Keeping the cursor centered.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Center screen
vim.keymap.set("n", "gg", "ggzv")
vim.keymap.set("n", "G", "Gzv")

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Same when moving up and down
vim.keymap.set("", "<C-d>", "<C-d>zz")
vim.keymap.set("", "<C-u>", "<C-u>zz")

-- Use c-\ to do c-] but open it in a new split.
vim.keymap.set("n", "<c-]>", "<c-]>zz")
vim.keymap.set("n", "<c-\\>", ":vertical wincmd ]<cr>zz")

-- [w ]w - Forward and backwards tabs
vim.keymap.set("n", "[w", "<esc>:tabprevious<cr>")
vim.keymap.set("n", "]w", "<esc>:tabnext<cr>")

-- [W ]W - Move tabs
vim.keymap.set("n", "[W", "<esc>:tabmove -1<cr>")
vim.keymap.set("n", "]W", "<esc>:tabmove +1<cr>")

-- Space to toggle folds.
vim.keymap.set({ "n", "v" }, "<Space>", "za")

-- Ctrl-b: Go (b)ack. Go to previously buffer
vim.keymap.set("n", "<c-b>", "<c-^>")

-- Do NOT yank with x/s
vim.keymap.set("", "x", [["_x]])
vim.keymap.set("", "X", [["_d]])
vim.keymap.set("n", "s", [["_s]])
vim.keymap.set("n", "S", [["_S]])

-- Clean trailing whitespace
vim.keymap.set("n", "=w", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.api.nvim_win_set_cursor(0, curpos)
end)

-- Select last paste
vim.keymap.set({ "x", "o" }, "gp", function()
  local mode = vim.fn.mode()
  local is_visual = mode == "v" or mode == "V" or mode == "\22"

  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "["))
  vim.cmd.normal { is_visual and "o" or "v", bang = true }
  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "]"))
end)

-- Close quickfix/location window
vim.keymap.set("n", "<leader>c", function()
  local nr = vim.fn.winnr "$"
  if #vim.fn.getqflist() > 0 then
    vim.cmd.copen()
  end
  if nr == vim.fn.winnr "$" then
    vim.cmd.cclose()
  end
end)

-- Poweful <esc>.
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
  vim.snippet.stop()
  return "<esc>"
end, { expr = true })
