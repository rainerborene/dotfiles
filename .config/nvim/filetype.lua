vim.filetype.add {
  extension = {
    mdx = "mdx",
  },
  pattern = {
    ["Caddyfile.*"] = "caddy",
    [".*%.md%.erb"] = "markdown",
  },
}

vim.treesitter.language.register("markdown", "mdx")
