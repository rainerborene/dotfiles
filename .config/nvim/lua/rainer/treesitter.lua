local treesitter = require "nvim-treesitter.configs"

-- constants for selection_modes
local charwise = "v"
local linewise = "V"

---@diagnostic disable-next-line: missing-fields
treesitter.setup {
  ensure_installed = {
    "ruby",
    "json",
    "lua",
    "html",
    "javascript",
    "typescript",
    "sql",
    "tsx",
    "query",
    "vue",
    "vim",
    "caddy",
    "vimdoc",
    "css",
  },
  indent = {
    enable = false,
  },
  highlight = {
    enable = true,
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
        ["ar"] = "@block.outer",
        ["ir"] = "@block.inner",
      },
      selection_modes = {
        ["@parameter.outer"] = charwise,
        ["@function.outer"] = linewise,
        ["@class.outer"] = linewise,
        ["@block.outer"] = linewise,
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
