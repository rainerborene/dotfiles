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

return M
