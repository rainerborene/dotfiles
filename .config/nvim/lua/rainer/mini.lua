require("mini.operators").setup {
  exchange = {
    prefix = "cx",
  },
}

require("mini.align").setup {
  mappings = {
    start = "gl",
    start_with_preview = "gL",
  },
}

vim.keymap.del("x", "cx")
