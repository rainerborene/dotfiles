local Path = require "plenary.path"
local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    mappings = {
      n = {
        ["<C-g>"] = actions.close,
      },
      i = {
        ["<C-cr>"] = actions.nop,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
      },
    },
  },
}

require("telescope").load_extension "fzf"
require("telescope").load_extension "egrepify"

return {
  bundle_grep_string = function()
    if vim.b.bundler_paths == nil then
      return
    end

    vim.ui.input({ prompt = "Bundle Grep For > " }, function(input)
      if input == nil then
        return
      end
      vim.schedule(function()
        require("telescope.builtin").grep_string {
          cwd = tostring(Path:new(vim.b.bundler_paths[1]):parent()),
          search = input,
          search_dirs = vim.b.bundler_paths,
          use_regex = true,
          path_display = { absolute = false },
        }
      end)
    end)
  end,
}
