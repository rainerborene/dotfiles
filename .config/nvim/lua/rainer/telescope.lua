local Path = require "plenary.path"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

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

return {
  bundle_grep_string = function()
    if vim.b.bundler_paths == nil then
      return
    end

    vim.ui.input({ prompt = "Bundle Grep For > " }, function(input)
      if input == nil then
        return
      end
      require("telescope.builtin").grep_string {
        cwd = tostring(Path:new(vim.b.bundler_paths[1]):parent()),
        search = input,
        search_dirs = vim.b.bundler_paths,
        use_regex = true,
        path_display = { absolute = false },
      }
    end)
  end,

  -- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/telescope/multi-ripgrep.lua
  multi_ripgrep = function(opts)
    opts = opts or {}
    opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
    opts.pattern = opts.pattern or "%s"
    opts.shortcuts = opts.shortcuts or {
      ["rb"] = "*.rb",
      ["erb"] = "*.html.erb",
      ["js"] = "*.js",
    }

    local custom_grep = finders.new_async_job {
      command_generator = function(prompt)
        if not prompt or prompt == "" then
          return nil
        end

        local prompt_split = vim.split(prompt, "  ")

        local args = { "rg" }
        if prompt_split[1] then
          table.insert(args, "-e")
          table.insert(args, prompt_split[1])
        end

        if prompt_split[2] then
          table.insert(args, "-g")

          local pattern
          if opts.shortcuts[prompt_split[2]] then
            pattern = opts.shortcuts[prompt_split[2]]
          else
            pattern = prompt_split[2]
          end

          table.insert(args, string.format(opts.pattern, pattern))
        end

        return vim
          .iter({
            args,
            { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden" },
          })
          :flatten()
          :totable()
      end,
      entry_maker = make_entry.gen_from_vimgrep(opts),
      cwd = opts.cwd,
    }

    pickers
      .new(opts, {
        debounce = 100,
        prompt_title = "Live Grep (with shortcuts)",
        finder = custom_grep,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
      })
      :find()
  end,
}
