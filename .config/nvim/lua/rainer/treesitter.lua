require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby" },
  indent = {
    enable = false
  },
  highlight = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["am"] = "@class.outer",
        ["im"] = "@class.inner",
      },
    },
  },
  matchup = {
    enable = true
  }
}
