local ai = require "mini.ai"
local extra = require "mini.extra"

local folding = function()
  return function()
    vim.opt.foldexpr = vim.opt.foldexpr
    local lnum = vim.fn.line "."
    local start_line = vim.fn.foldclosed(lnum)
    local end_line = vim.fn.foldclosedend(lnum)
    if start_line < 0 then
      vim.cmd.foldclose { mods = { silent = true, emsg_silent = true } }
      start_line = vim.fn.foldclosed(lnum)
      end_line = vim.fn.foldclosedend(lnum)
      vim.cmd.foldopen { mods = { silent = true, emsg_silent = true } }
    end
    if start_line < 0 then
      return
    end
    return {
      from = { line = start_line, col = 1 },
      to = { line = end_line, col = 1 },
      vis_mode = "V",
    }
  end
end

require("mini.ai").setup {
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
    i = extra.gen_ai_spec.indent(),
    l = extra.gen_ai_spec.line(),
    z = folding(),
  },
}

require("mini.operators").setup {
  exchange = {
    prefix = "cx",
  },
}

vim.keymap.del("x", "cx")

require("mini.align").setup {
  mappings = {
    start = "gl",
    start_with_preview = "gL",
  },
}
