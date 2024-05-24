require("conform").setup {
  formatters_by_ft = {
    ruby = { "rubocop" },
    html = { "prettierhtml" },
    json = { "jq" },
    eruby = { "prettierhtml" },
    javascript = { "biome" },
    xml = { "xmllint" },
    lua = { "stylua" },
  },
  formatters = {
    rubocop = {
      args = { "--server", "--auto-correct-all", "--force-exclusion", "--stderr", "--stdin", "$FILENAME" },
    },
    prettier = {
      options = {
        ft_parsers = {
          eruby = "html",
        },
      },
    },
    prettierhtml = {
      command = "prettier",
      args = { "--parser", "html", "--print-width", "200" },
    },
  },
}

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_fallback = true, range = range }
end, { range = true })
