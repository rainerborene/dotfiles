local lint = require "lint"

lint.linters_by_ft = {
  ruby = { "ruby", "rubocop" },
  json = { "jq" },
  javascript = { "biomejs" },
  eruby = { "erb_lint" },
}

lint.linters.erb_lint.cmd = "erblint"
lint.linters.erb_lint.args = { "--format", "compact" }
