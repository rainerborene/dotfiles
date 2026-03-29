local M = {}

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

M.tailwind_sort_classes = function(class_texts)
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ name = "tailwindcss" })[1]
  if not client then
    return class_texts[1]
  end

  local params = vim.tbl_extend("error", vim.lsp.util.make_text_document_params(bufnr), {
    classLists = class_texts,
  })

  ---@diagnostic disable-next-line: param-type-mismatch
  local response, err = client.request_sync("@/tailwindCSS/sortSelection", params, 2000, bufnr)
  if not response or err or not response.result then
    return class_texts[1]
  end

  return response.result.classLists[1]
end

M.tabline = function()
  local s = ""

  for tabnr = 1, vim.fn.tabpagenr "$" do
    local is_current_tab = (tabnr == vim.fn.tabpagenr())
    local winnr = vim.fn.tabpagewinnr(tabnr)

    -- If current tab has a floating window focused, use the last non-floating window instead
    if is_current_tab then
      local cur_win = vim.api.nvim_get_current_win()
      local config = vim.api.nvim_win_get_config(cur_win)

      if config.relative ~= "" then -- floating window
        local wins = vim.api.nvim_tabpage_list_wins(0)
        for i = #wins, 1, -1 do
          local win = wins[i]
          local win_config = vim.api.nvim_win_get_config(win)
          if win_config.relative == "" then -- found a normal window
            winnr = vim.fn.win_id2win(win)
            break
          end
        end
      end
    end

    local buflist = vim.fn.tabpagebuflist(tabnr)
    local buf = buflist[winnr] or buflist[1] or 0
    local bufname = vim.fn.bufname(buf)
    local bufname_short = vim.fn.fnamemodify(bufname, ":t")

    if bufname_short == "" then
      bufname_short = "[No Name]"
    end

    if is_current_tab then
      s = s .. "%#TabLineSel#" .. " " .. bufname_short .. " "
    else
      s = s .. "%#TabLine#" .. " " .. bufname_short .. " "
    end
  end

  return s .. "%#TabLineFill#"
end

return M
