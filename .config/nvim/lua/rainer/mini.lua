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

require("mini.jump2d").setup {
  labels = "asdfjklghqwertyuiopzxcvbnm",
  view = {
    dim = true,
  },
  mappings = {
    start_jumping = "",
  },
  allowed_lines = {
    cursor_at = false,
    blank = false,
    fold = false,
  },
  allowed_windows = {
    not_current = false,
  },
}

-- https://github.com/echasnovski/mini.nvim/discussions/1033
vim.keymap.set("n", "m", function()
  local builtin = MiniJump2d.builtin_opts.word_start
  builtin.view = { n_steps_ahead = 10 }
  MiniJump2d.start(builtin)
end)

vim.keymap.set({ "x", "o" }, "m", function()
  MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end)

vim.keymap.set("n", "M", function()
  MiniJump2d.start(MiniJump2d.builtin_opts.line_start)
end)

vim.keymap.del("x", "cx")
