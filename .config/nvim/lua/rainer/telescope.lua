local Path = require('plenary.path')
local actions = require('telescope.actions')
local M = {}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-g>"] = actions.close
      },
      n = {
        ["<C-g>"] = actions.close
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true
    },
  }
}

require('telescope').load_extension('fzf')

local function bundler_project()
  return vim.fn['bundler#project']()
end

local function gem_paths()
  return bundler_project()._sorted
end

local function gem_path()
  local sample = gem_paths()[1]
  return tostring(Path:new(sample):parent())
end

local function no_bundler()
  return vim.tbl_isempty(bundler_project())
end

function M.bundle_grep_string()
  if no_bundler() then return end

  return require('telescope.builtin').grep_string {
    cwd = gem_path(),
    search = vim.fn.input("Bundle Grep For > "),
    search_dirs = gem_paths(),
    use_regex = true
  }
end

return M
