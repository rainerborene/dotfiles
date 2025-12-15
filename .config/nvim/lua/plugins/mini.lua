return {
  {
    "nvim-mini/mini.ai",
    config = function()
      local ai = require "mini.ai"

      ai.setup {
        n_lines = 500,
        mappings = {
          around_next = "",
          inside_next = "",
          around_last = "",
          inside_last = "",
        },
        custom_textobjects = {
          t = { "<([%p%w]-).->.-</%1>", "^<.-[^%%-]>().*()</[^/]->$" }, -- tags
          d = {
            {
              -- Cam*elCase
              { "()()%u[%l%d]+()%f[^%l%d]()" },
              -- a*aa_bbb
              { "[^%w]()()[%w]+()_()" },
              -- a*aa_bb
              { "^()()[%w]+()_()" },
              -- aaa_bbb*_ccc
              { "_()()[%w]+()_()" },
              -- bbb_cc*cc
              { "()_()[%w]+()()%f[%W]" },
              -- bbb_cc*c at the end of the line
              { "()_()[%w]+()()$" },
            },
          },

          E = ai.gen_spec.pair("<%= ", "%>"),
          l = function(ai_type)
            local line_num = vim.fn.line "."
            local line = vim.fn.getline(line_num)
            -- Ignore indentation for `i` textobject
            local from_col = ai_type == "a" and 1 or (line:match("^(%s*)"):len() + 1)
            -- Don't select `\n` past the line to operate within a line
            local to_col = line:len()

            return { from = { line = line_num, col = from_col }, to = { line = line_num, col = to_col } }
          end,

          -- Whole buffer
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line "$",
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }
    end,
  },
  {
    "nvim-mini/mini.align",
    opts = {
      mappings = {
        start = "gl",
        start_with_preview = "gL",
      },
    },
  },
  {
    "nvim-mini/mini.operators",
    opts = {
      exchange = {
        prefix = "cx",
      },
    },
    config = function(_, opts)
      require("mini.operators").setup(opts)

      -- Make c work in visual mode
      vim.keymap.del("x", "cx")
    end,
  },
  {
    "nvim-mini/mini.splitjoin",
    opts = {
      mappings = {
        toggle = "",
        split = "gS",
        join = "gJ",
      },
    },
  },
}
