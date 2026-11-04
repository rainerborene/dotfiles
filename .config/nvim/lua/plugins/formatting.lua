return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      ruby = { "rubocop" },
      html = { "oxfmthtml" },
      svg = { "oxfmthtml" },
      json = { "jq" },
      eruby = { "herb" },
      javascript = { "oxfmt" },
      css = { "oxfmt" },
      vue = { "oxfmt" },
      xml = { "xmllint" },
      lua = { "stylua" },
    },
    formatters = {
      rubocop = {
        args = { "--server", "--autocorrect-all", "--force-exclusion", "--stderr", "--stdin", "$FILENAME" },
      },
      oxfmthtml = {
        command = "oxfmt",
        -- oxfmt picks the parser from the extension and rejects .svg, so always claim .html
        args = function(_, ctx)
          return { "--config", vim.fn.stdpath("config") .. "/oxfmtrc.json", "--stdin-filepath", ctx.filename .. ".html" }
        end,
        stdin = true,
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
    {
      "=w",
      function()
        require("conform").format { formatters = { "trim_whitespace", "trim_newlines" } }
      end,
      desc = "Clean trailing whitespace",
    },
  },
}
