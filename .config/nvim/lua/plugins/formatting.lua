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
        require("conform").format({ async = true, lsp_format = "fallback" }, function()
          local mode = vim.api.nvim_get_mode().mode
          if not vim.startswith(string.lower(mode), "v") then
            return
          end

          local start_pos = vim.api.nvim_buf_get_mark(0, "<")
          local end_pos = vim.api.nvim_buf_get_mark(0, ">")

          vim.lsp.buf.format {
            range = {
              start = { start_pos[1], start_pos[2] },
              ["end"] = { end_pos[1], end_pos[2] },
            },
          }

          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        end)
      end,
      mode = { "n", "v" },
    },
  },
}
