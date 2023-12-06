local Path = require('plenary.path')
local actions = require('telescope.actions')
local M = {}

require('telescope').setup {
  defaults = {
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
  local sample = bundler_project()._paths['rails']
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
    use_regex = true,
    path_display = { absolute = false }
  }
end

return M
