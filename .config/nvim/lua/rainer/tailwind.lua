local function sort(class_texts)
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ name = "tailwindcss" })[1]
  if not client then
    return class_texts[1]
  end

  local params = vim.tbl_extend("error", vim.lsp.util.make_text_document_params(bufnr), {
    classLists = class_texts,
  })

  local response = client.request_sync("@/tailwindCSS/sortSelection", params, 2000, bufnr)

  if not response or response.err or not response.result then
    return class_texts[1]
  end

  return response.result.classLists[1]
end

return { sort = sort }
