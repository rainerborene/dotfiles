require("oil").setup {
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["l"] = "actions.select",
    ["v"] = "actions.select_vsplit",
    ["i"] = "actions.select_split",
    ["t"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["q"] = "actions.close",
    ["h"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
  use_default_keymaps = false,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return vim.startswith(name, "..")
    end,
  },
}
