require("mini.surround").setup()
require("mini.operators").setup {
  exchange = {
    prefix = "cx",
    reindent_linewise = true,
  },
}

require("mini.align").setup {
  mappings = {
    start = "gl",
    start_with_preview = "gL",
  },
}

local gen_ai_spec = require("mini.extra").gen_ai_spec
local spec_pair = require("mini.ai").gen_spec.pair

require("mini.ai").setup {
  mappings = {
    around_last = "aN",
    inside_last = "iN",
  },
  custom_textobjects = {
    i = gen_ai_spec.indent(),
    e = gen_ai_spec.buffer(),
    l = gen_ai_spec.line(),
    E = spec_pair("<%=", "%>"),
    P = function()
      local start_line, start_col = unpack(vim.fn.getpos "'[", 2, 3)
      local end_line, end_col = unpack(vim.fn.getpos "']", 2, 3)
      if start_line == end_line and start_col == end_col then
        return
      end
      return {
        from = { line = start_line, col = start_col },
        to = { line = end_line, col = end_col },
      }
    end,
    z = function(ai_type)
      local foldlevel = vim.fn.foldlevel(vim.fn.line ".")
      if foldlevel <= 0 then
        return
      end
      vim.cmd.normal { "zxzc", bang = true }
      local start_line = vim.fn.foldclosed(vim.fn.line ".")
      local end_line = vim.fn.foldclosedend(vim.fn.line ".")
      vim.cmd.normal { "zo", bang = true }
      if ai_type == "i" then
        start_line = start_line + 1
        end_line = end_line - 1
      end
      return {
        from = { line = start_line, col = 1 },
        to = { line = end_line, col = 1 },
        vis_mode = "V",
      }
    end,
  },
}

-- alias
vim.keymap.set("o", "gp", "aP", { remap = true })
