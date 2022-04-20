local lir = require('lir')
local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')
local Job = require('plenary.job')

lir.setup {
  show_hidden_files = true,
  mappings = {
    ['<CR>'] = actions.edit,
    ['l'] = actions.edit,
    ['i'] = actions.split,
    ['v'] = actions.vsplit,
    ['t'] = actions.tabedit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['M'] = actions.mkdir,
    ['F'] = actions.newfile,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['D'] = actions.delete,
    ['.'] = actions.toggle_show_hidden,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,

    ['I'] = function()
      local ctx = lir.get_context()
      local current = ctx:current()

      Job:new({
        command = 'identify',
        args = { '-format', '%f [%wx%h]', current.value },
        cwd = ctx.dir,
        on_exit = function(j, return_val)
          print(table.concat(j:result(), " "))
        end,
      }):sync()
    end
  },
}
