local map = vim.keymap.set
local unmap = vim.keymap.del
local command = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("rainer_" .. name, { clear = true })
end

autocmd("TextYankPost", {
  group = augroup "yank_highlight",
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank()
  end,
})

autocmd("CmdwinEnter", {
  callback = function(args)
    unmap({ "n", "x", "o" }, "<cr>", { buffer = args.buf })
    map("n", "<c-c>", "<Cmd>quit<cr>", { buffer = args.buf })
  end,
})

autocmd("FileType", {
  group = augroup "close_with_q",
  desc = "Close with <q>",
  pattern = {
    "fugitive",
    "fugitiveblame",
    "git",
    "gitsigns-blame",
    "help",
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    map("n", "q", function()
      vim.cmd.close { mods = { silent = true, emsg_silent = true } }
      pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
    end, { buffer = event.buf, silent = true })
  end,
})

local au_cursorline = augroup "cursorline_focus"

autocmd({ "CursorHold", "CursorHoldI", "WinEnter" }, {
  group = au_cursorline,
  desc = "Show cursorline in active window",
  callback = function()
    vim.wo.cursorline = true
  end,
})

autocmd({ "CursorMoved", "CursorMovedI", "WinLeave" }, {
  group = au_cursorline,
  desc = "Hide cursorline in insert mode and inactive windows",
  callback = function()
    vim.wo.cursorline = false
  end,
})

autocmd("VimResized", {
  group = augroup "resize_splits",
  desc = "Auto-resize splits when window is resized",
  pattern = "*",
  command = "wincmd =",
})

autocmd("BufReadPost", {
  group = augroup "last_loc",
  desc = "Go to the last location when opening a buffer",
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.startswith(bufname, "fugitive://") or bufname:match ".git/" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

autocmd("BufWritePre", {
  group = augroup "auto_create_dir",
  desc = "Auto create dir when saving a file",
  callback = function(event)
    if event.match:match "^%w%w+://" then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd("CursorMoved", {
  group = augroup "center_on_search",
  desc = "Center screen on search highlighting",
  callback = function()
    if vim.o.hlsearch then
      vim.api.nvim_feedkeys("zz", "n", false)
    end
  end,
})

command("Nopen", function(opts)
  local path = "node_modules/" .. opts.args
  if vim.fn.isdirectory(path) == 0 then
    return
  end
  vim.cmd.tabedit(path)
  vim.cmd.tcd(path)
end, {
  nargs = 1,
  desc = "Open NPM package in a new tab",
  complete = function(arg_lead, _, _)
    return vim
      .iter(vim.fn.globpath("node_modules", arg_lead .. "*", true, true))
      :map(function(val)
        return string.sub(val, string.len "node_modules/" + 1)
      end)
      :totable()
  end,
})
