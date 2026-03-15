return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      ruby = { "rubocop" },
      html = { "prettierhtml" },
      json = { "jq" },
      eruby = { "herb" },
      javascript = { "biome" },
      vue = { "biome" },
      xml = { "xmllint" },
      lua = { "stylua" },
    },
    formatters = {
      rubocop = {
        args = { "--server", "--auto-correct-all", "--force-exclusion", "--stderr", "--stdin", "$FILENAME" },
      },
      prettierhtml = {
        command = "prettier",
        args = { "--parser", "html", "--print-width", "200" },
      },
      herb = {
        command = "herb-format",
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

          vim.cmd.normal { "mq=`q", bang = true, mods = { silent = true, emsg_silent = true } }
        end)
      end,
      mode = { "n", "v" },
    },
  },
}
