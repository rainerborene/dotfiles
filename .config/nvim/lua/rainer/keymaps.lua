local map = vim.keymap.set

-- Easy command-line mode
map("", ";", ":")

-- Easier bracket matching
map("", "<Tab>", "%", { remap = true })
map("", "<C-o>", "<Nop>")

-- Keep the cursor in place while joining lines
map("n", "J", "mzJ`z")

-- Always start inserting at the end of input fields
map("", "gi", "gi<End>")

-- Move to last change
map("n", "gI", "`.zz")

-- Quit
map("i", "<c-q>", "<esc><cmd>q<cr>")
map("n", "<c-q>", "<cmd>q<cr>")

-- Save
map({ "i", "n" }, "<C-s>", "<cmd>update<cr>")

-- Open the package manager.
map("n", "<leader>L", "<cmd>Lazy<cr>")

-- Split windows
map("n", "<leader>s", "<C-W>s")
map("n", "<leader>v", "<C-W>v")

-- Breaking the bad habit
map("n", "U", "<Nop>")

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
map("n", "<leader>n", "<cmd>tabedit /mnt/c/Users/Rainer\\ Borene/Dropbox/Notebook/Notes<cr>")

-- Fast escape from insert mode
map("i", "jj", "<esc>", { remap = true })
map("i", "<c-c>", "<esc>", { remap = true })

-- Faster scrolling
map("n", "<c-e>", "5<c-e>")
map("n", "<c-y>", "5<c-y>")

-- Remap for dealing with word wrap and adding jumps to the jumplist.
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Map n/N to always move in the same direction.
map("n", "n", "'Nn'[v:searchforward]", { silent = true, expr = true })
map("n", "N", "'nN'[v:searchforward]", { silent = true, expr = true })

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
map("n", "<c-\\>", "<cmd>vertical wincmd ]<cr>zz")

-- `gf` opens file under cursor in a new vertical split
map("c", "<Plug><cfile>", "<C-R><C-F>")
map("n", "gf", ":vert sfind <Plug><cfile><CR>")

-- [w ]w - Forward and backwards tabs
map("n", "[w", "<cmd>tabprevious<cr>")
map("n", "]w", "<cmd>tabnext<cr>")

-- [W ]W - Move tabs
map("n", "[W", "<cmd>tabmove -1<cr>")
map("n", "]W", "<cmd>tabmove +1<cr>")

-- Space to toggle folds.
map({ "n", "v" }, "<Space>", "za")

-- Ctrl-b: Go (b)ack. Go to previously buffer
map("n", "<c-b>", "<c-^>")

-- Goto older/newer position in change list
map("n", "(", "g;zvzz", { silent = true })
map("n", ")", "g,zvzz", { silent = true })

-- Do NOT yank with x/s
map("", "x", [["_x]])
map("", "X", [["_d]])
map("n", "s", [["_s]])
map("n", "S", [["_S]])

-- Change current word and prepare to repeat next occurence (like *cgn)
map("n", "c*", [[:<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>cgn]])

-- Expand %% to current directory in command mode
vim.cmd.cabbr { args = { "<expr>", "%%", "&filetype == 'oil' ? bufname('%')[6:] : expand('%:h')" } }

-- Stay star motions
local better_hlsearch = function()
  local current_word = vim.fn.expand "<cword>"
  vim.fn.setreg("/", "\\<" .. current_word .. "\\>")
  vim.opt.hlsearch = true
end

map("n", "#", better_hlsearch)
map("n", "*", better_hlsearch)

-- Disable hlsearch automatically when your search done and enable on next searching
vim.on_key(function(char)
  local is_normal = vim.fn.mode() == "n" and char ~= "z"
  local ok, prompt = pcall(require, "flash.prompt")
  if not is_normal or ok and prompt.visible() then
    return
  end
  local keys = { "<CR>", "n", "N", "*", "#", "?", "/" }
  local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

  if vim.o.hlsearch ~= new_hlsearch then
    vim.o.hlsearch = new_hlsearch
  end
end, vim.api.nvim_create_namespace "toggle_hlsearch")

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
    vim.cmd.copen { mods = { split = "botright" } }
  end
  if nr == vim.fn.winnr "$" then
    vim.cmd.cclose()
  end
end)

-- Stop snippet on escape
map({ "i", "s", "n" }, "<esc>", function()
  vim.snippet.stop()
  return "<esc>"
end, { expr = true })
