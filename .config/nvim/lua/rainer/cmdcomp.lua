local should_complete = false
local ctrl_z = vim.api.nvim_replace_termcodes("<C-z>", true, false, true)

vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function()
    if not should_complete or vim.fn.getcmdcompltype() == "" then
      return
    end
    vim.api.nvim__redraw { flush = true }
    local line_before_autoselect = vim.fn.getcmdline()
    vim.api.nvim_feedkeys(ctrl_z, "n", false)
    vim.schedule(function()
      if line_before_autoselect ~= vim.fn.getcmdline() then
        vim.fn.setcmdline(line_before_autoselect)
      end
      should_complete = false
    end)
  end,
})

vim.on_key(function(_, typed)
  should_complete = false
  if not vim.fn.mode() == "c" or typed:match "%%" then
    return
  end
  local is_tab = string.byte(typed) == 9
  local is_backspace = string.byte(typed) == 128
  local is_printable = typed:match "^%g$"

  should_complete = not is_tab and (is_backspace or is_printable)
end)
