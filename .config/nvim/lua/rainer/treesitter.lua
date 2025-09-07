local treesitter = require "nvim-treesitter.configs"

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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<cr>",
      node_incremental = "<cr>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
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
        ["@function.outer"] = "V",
        ["@block.outer"] = "V",
        ["@class.outer"] = "V",
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
