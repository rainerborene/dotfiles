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
    win = {
      input = {
        keys = {
          ["<c-a>"] = "",
          ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
          ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
          ["<PageUp>"] = { "list_scroll_up", mode = { "i", "n" } },
          ["<PageDown>"] = { "list_scroll_down", mode = { "i", "n" } },
        },
      },
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
        cwd = vim.b.bundler_paths[1]:match "(.*/).-$",
        search = input,
        dirs = vim.b.bundler_paths,
        regex = true,
      }
    end)
  end,
}
