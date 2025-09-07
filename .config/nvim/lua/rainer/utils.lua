local M = {}

vim.api.nvim_create_user_command("Nopen", function(opts)
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

M.fold_text = function()
  local line = vim.fn.getline(vim.v.foldstart)
  local nucolwidth = tonumber(vim.o.foldcolumn) + (vim.o.number and 1 or 0) * vim.o.numberwidth
  local windowwidth = vim.fn.winwidth(0) - nucolwidth - (vim.o.number and vim.o.numberwidth or 2)
  local foldedlinecount = vim.v.foldend - vim.v.foldstart

  -- Expand tabs into spaces
  local onetab = string.sub("          ", 1, vim.o.tabstop)
  line = string.gsub(line, "\t", onetab)

  -- Truncate line and calculate fill characters
  line = string.sub(line, 1, windowwidth - 2 - #tostring(foldedlinecount))
  local fillcharcount = windowwidth - #line - #tostring(foldedlinecount)

  return line .. "…" .. string.rep(" ", fillcharcount) .. foldedlinecount .. "…" .. " "
end

M.qf_toggle = function()
  local nr = vim.fn.winnr "$"
  if #vim.fn.getqflist() > 0 then
    vim.cmd.copen()
  end
  if nr == vim.fn.winnr "$" then
    vim.cmd.cclose()
  end
end

M.select_last_change = function()
  local mode = vim.fn.mode()
  local is_visual = mode == "v" or mode == "V" or mode == "\22"

  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "["))
  vim.cmd.normal { is_visual and "o" or "v", bang = true }
  vim.api.nvim_win_set_cursor(0, vim.api.nvim_buf_get_mark(0, "]"))
end

return M
