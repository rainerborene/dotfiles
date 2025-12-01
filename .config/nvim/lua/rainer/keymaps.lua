-- Easy command-line mode
vim.keymap.set("", ";", ":")

-- Easier bracket matching
vim.keymap.set("", "<Tab>", "%", { remap = true })
vim.keymap.set("", "<C-o>", "<Nop>")

-- Quit
vim.keymap.set("i", "<c-q>", "<esc>:q<cr>", { silent = true })
vim.keymap.set("n", "<c-q>", ":q<cr>", { silent = true })

-- Save
vim.keymap.set("i", "<C-s>", "<C-o>:update<cr>", { silent = true })
vim.keymap.set("n", "<C-s>", ":update<cr>", { silent = true })

-- Split windows
vim.keymap.set("n", "<leader>s", "<C-W>s")
vim.keymap.set("n", "<leader>v", "<C-W>v")

-- Breaking the bad habit
vim.keymap.set("n", "U", "<Nop>")

-- Easier to type, and I never use the default behavior.
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "o" }, "L", "$")
vim.keymap.set("x", "L", "g_")

-- No overwrite paste
vim.keymap.set("x", "p", [["_dP]])

-- Reindent entire file
vim.keymap.set("n", "==", [[mqHmwgg=G`wzt`q]])

-- Easy filetype switching
vim.keymap.set("n", "=f", ":setfiletype<Space>")

-- Open notes directory
vim.keymap.set("n", "<leader>n", ":tabedit /mnt/c/Users/Rainer\\ Borene/Dropbox/Notebook/Notes<cr>", { silent = true })

-- Fast escape from insert mode
vim.keymap.set("i", "jj", "<esc>", { remap = true })
vim.keymap.set("i", "<c-c>", "<esc>", { remap = true })

-- Faster scrolling
vim.keymap.set("n", "<c-e>", "5<c-e>")
vim.keymap.set("n", "<c-y>", "5<c-y>")

-- Remap for dealing with word wrap and adding jumps to the jumplist.
vim.keymap.set("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Map n/N to always move in the same direction.
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { silent = true, expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { silent = true, expr = true })

-- Center screen
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "G", "Gzz")

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Same when moving up and down
vim.keymap.set("", "<C-d>", "<C-d>zz")
vim.keymap.set("", "<C-u>", "<C-u>zz")

-- Use c-\ to do c-] but open it in a new split.
vim.keymap.set("n", "<c-]>", "<c-]>zz")
vim.keymap.set("n", "<c-\\>", ":vertical wincmd ]<cr>zz", { silent = true })

-- `gf` opens file under cursor in a new vertical split
vim.keymap.set("c", "<Plug><cfile>", "<C-R><C-F>")
vim.keymap.set("n", "gf", ":vert sfind <Plug><cfile><CR>")

-- [w ]w - Forward and backwards tabs
vim.keymap.set("n", "[w", "<esc>:tabprevious<cr>", { silent = true })
vim.keymap.set("n", "]w", "<esc>:tabnext<cr>", { silent = true })

-- [W ]W - Move tabs
vim.keymap.set("n", "[W", "<esc>:tabmove -1<cr>", { silent = true })
vim.keymap.set("n", "]W", "<esc>:tabmove +1<cr>", { silent = true })

-- Space to toggle folds.
vim.keymap.set({ "n", "v" }, "<Space>", "za")

-- Ctrl-b: Go (b)ack. Go to previously buffer
vim.keymap.set("n", "<c-b>", "<c-^>")

-- Do NOT yank with x/s
vim.keymap.set("", "x", [["_x]])
vim.keymap.set("", "X", [["_d]])
vim.keymap.set("n", "s", [["_s]])
vim.keymap.set("n", "S", [["_S]])

-- Stay star motions
local better_hlsearch = function()
  local current_word = vim.fn.expand "<cword>"
  vim.fn.setreg("/", "\\<" .. current_word .. "\\>")
  vim.opt.hlsearch = true
end

vim.keymap.set("n", "#", better_hlsearch)
vim.keymap.set("n", "*", better_hlsearch)

-- Clean trailing whitespace
vim.keymap.set("n", "=w", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.cmd [[keeppatterns %s/\r//e]]
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

-- Stop snippet on escape
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
  vim.snippet.stop()
  return "<esc>"
end, { expr = true })

-- Disable hlsearch automatically when your search done and enable on next searching
vim.on_key(function(char)
  local is_normal = vim.fn.mode() == "n" and char ~= "z"
  if not is_normal or require("flash.prompt").visible() then
    return
  end
  local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
  local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

  if vim.o.hlsearch ~= new_hlsearch then
    vim.o.hlsearch = new_hlsearch
  end
end, vim.api.nvim_create_namespace "toggle_hlsearch")
