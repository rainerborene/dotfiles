vim.filetype.add {
  extension = {
    mdx = "mdx",
  },
  pattern = {
    ["Caddyfile.*"] = "caddy",
  },
}

vim.treesitter.language.register("markdown", "mdx")
