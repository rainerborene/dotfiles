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
          t = false,
          d = {
            {
              "%f[%a]%l+%d*",
              "%f[%w]%d+",
              "%f[%u]%u%f[%A]%d*",
              "%f[%u]%u%l+%d*",
              "%f[%u]%u%u+%d*",
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

          -- Rectangular column around the word under (or nearest to) cursor
          v = function(ai_type)
            local cursor = vim.api.nvim_win_get_cursor(0)
            local cur_row, cur_col = cursor[1], cursor[2] + 1
            local cur_line = vim.fn.getline(cur_row)
            if cur_line == "" then
              return nil
            end

            local function is_word(ch)
              return ch ~= "" and ch:match "[%w_]" ~= nil
            end

            -- Anchor on a word: cursor itself, else nearest word on the line
            local pos = cur_col
            if not is_word(cur_line:sub(pos, pos)) then
              local fwd = cur_line:find("[%w_]", pos)
              local back
              for i = pos - 1, 1, -1 do
                if is_word(cur_line:sub(i, i)) then
                  back = i
                  break
                end
              end
              if fwd and back then
                pos = (fwd - cur_col) <= (cur_col - back) and fwd or back
              else
                pos = fwd or back
              end
              if not pos then
                return nil
              end
            end

            local s = pos
            while s > 1 and is_word(cur_line:sub(s - 1, s - 1)) do
              s = s - 1
            end
            local e = pos
            while e < #cur_line and is_word(cur_line:sub(e + 1, e + 1)) do
              e = e + 1
            end

            local function has_word(row)
              return vim.fn.getline(row):sub(s, e):match "[%w_]" ~= nil
            end

            local top, bot = cur_row, cur_row
            local last = vim.fn.line "$"
            while top > 1 and has_word(top - 1) do
              top = top - 1
            end
            while bot < last and has_word(bot + 1) do
              bot = bot + 1
            end

            if ai_type == "a" then
              while e < #cur_line and cur_line:sub(e + 1, e + 1):match "%s" do
                e = e + 1
              end
            end

            return {
              from = { line = top, col = s },
              to = { line = bot, col = e },
              vis_mode = "\22",
            }
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
    "nvim-mini/mini.indentscope",
    version = false,
    event = "VeryLazy",
    config = function()
      local mini_indent = require "mini.indentscope"
      mini_indent.setup {
        options = { try_as_border = true },
        symbol = "│",
        draw = {
          delay = 0,
          animation = mini_indent.gen_animation.none(),
        },
      }

      vim.g.miniindentscope_disable = true
    end,
  },
}
