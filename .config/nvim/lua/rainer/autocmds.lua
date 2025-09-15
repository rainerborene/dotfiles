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

autocmd("FileType", {
  group = augroup "git",
  pattern = { "gitcommit", "git" },
  callback = function()
    vim.opt_local.foldmethod = "syntax"
    vim.opt_local.spell = true
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup "close_with_q",
  desc = "Close with <q>",
  pattern = {
    "git",
    "fugitive",
    "help",
    "qf",
  },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
  end,
})

-- Open NPM package in a new tab
command("Nopen", function(opts)
  local path = "node_modules/" .. opts.args
  if vim.fn.isdirectory(path) == 0 then
    return
  end
  vim.cmd.tabedit(path)
  vim.cmd.tcd(path)
end, {
  nargs = 1,
  complete = function(arg_lead, _, _)
    return vim
      .iter(vim.fn.globpath("node_modules", arg_lead .. "*", true, true))
      :map(function(val)
        return string.sub(val, string.len "node_modules/" + 1)
      end)
      :totable()
  end,
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = augroup "resize_splits",
  pattern = "*",
  command = "wincmd =",
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
