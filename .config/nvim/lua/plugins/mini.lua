return {
  {
    "nvim-mini/mini.ai",
    dependencies = { "nvim-mini/mini.extra" },
    config = function()
      local ai = require "mini.ai"
      local extra = require "mini.extra"

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
          e = extra.gen_ai_spec.buffer(),
          l = extra.gen_ai_spec.line(),
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
