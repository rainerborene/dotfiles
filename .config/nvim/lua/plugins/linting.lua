return {
  "mfussenegger/nvim-lint",
  event = "VeryLazy",
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      ruby = { "rubocop" },
      json = { "jq" },
      javascript = { "oxlint" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        if vim.bo.modifiable and vim.bo.filetype ~= "eruby.yaml" then
          lint.try_lint(nil, { ignore_errors = true })
        end
      end,
    })
  end,
}
