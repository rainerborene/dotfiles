local Path = require "plenary.path"

require("snacks").setup {
  picker = {
    icons = {
      files = { enabled = false },
    },
    sources = {
      files = { hidden = true },
      grep = { hidden = true },
      grep_word = { hidden = true },
    },
    layout = {
      preset = "telescope",
      cycle = false,
    },
  },
}

return {
  bundle_grep_word = function()
    if vim.b.bundler_paths == nil then
      return
    end

    vim.ui.input({ prompt = "Bundle Grep For > " }, function(input)
      if input == nil then
        return
      end
      Snacks.picker.grep_word {
        cwd = tostring(Path:new(vim.b.bundler_paths[1]):parent()),
        search = input,
        dirs = vim.b.bundler_paths,
        regex = true,
      }
    end)
  end,
}
