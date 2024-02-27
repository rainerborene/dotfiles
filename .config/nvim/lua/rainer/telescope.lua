local Path = require('plenary.path')
local actions = require('telescope.actions')

require('telescope').setup {
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
        ["<C-g>"] = actions.close
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true
    },
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        }
      }
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('egrepify')

local function bundler_project()
  return vim.fn['bundler#project']()
end

local function gem_paths()
  return bundler_project()._sorted
end

local function gem_path()
  local sample = bundler_project()._paths['rails']
  return tostring(Path:new(sample):parent())
end

local function no_bundler()
  return vim.tbl_isempty(bundler_project())
end

return {
  bundle_grep_string = function()
    if no_bundler() then return end

    return require('telescope.builtin').grep_string {
      cwd = gem_path(),
      search = vim.fn.input("Bundle Grep For > "),
      search_dirs = gem_paths(),
      use_regex = true,
      path_display = { absolute = false }
    }
  end
}
