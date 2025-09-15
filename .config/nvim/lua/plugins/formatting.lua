return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      ruby = { "rubocop" },
      html = { "prettierhtml" },
      json = { "jq" },
      eruby = { "prettierhtml" },
      javascript = { "biome" },
      vue = { "biome" },
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
  },
  keys = {
    {
      "<F8>",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      mode = { "n", "v" },
    },
  },
}
