return {
  { "tpope/vim-unimpaired" },
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["v"] = "actions.select_vsplit",
        ["i"] = "actions.select_split",
        ["t"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["q"] = "actions.close",
        ["-"] = "actions.parent",
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
    },
    keys = {
      { "<leader>e", "<Cmd>Oil<cr>" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      at_edge = "stop",
    },
    -- stylua: ignore
    keys = {
      -- Resize splits
      { "<A-h>", function() require("smart-splits").resize_left() end, },
      { "<A-j>", function() require("smart-splits").resize_down() end, },
      { "<A-k>", function() require("smart-splits").resize_up() end, },
      { "<A-l>", function() require("smart-splits").resize_right() end, },

      -- Moving between splits
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>x",
        function()
          require("grug-far").toggle_instance {
            instanceName = "far",
            staticTitle = "Search and Replace",
          }
        end,
      },
      {
        "<leader>X",
        function()
          require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
        end,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          multi_line = false,
          highlight = { backdrop = false },
        },
      },
    },
    keys = {
      {
        "m",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
      },
      {
        "r",
        function()
          require("flash").treesitter_search()
        end,
        mode = "o",
      },
      {
        "R",
        function()
          require("flash").remote()
        end,
        mode = "o",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    opts = {
      "telescope",
      fzf_opts = {
        ["--no-cycle"] = true,
      },
      winopts = {
        backdrop = 100,
        preview = {
          scrollbar = false,
        },
      },
      grep = {
        hidden = true,
      },
      git = {
        commits = {
          cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset %C(blue)%ad%Creset ]]
            .. [[%s %C(black)<%an>%Creset" --date=format:"%a %H:%M"]],
          actions = {
            ["enter"] = function(line, _)
              vim.cmd.DiffviewOpen(line[1]:match "[^ ]+" .. "^!")
            end,
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "z=", function() require("fzf-lua").spell_suggest() end },
      { "<leader><leader>", function() require("fzf-lua").files() end },
      { "<leader><tab>", function() require("fzf-lua").keymaps() end },
      { "<leader>a", function() require("fzf-lua").live_grep() end },
      { "<leader>A", function() require("fzf-lua").grep_cword() end },
      { "<leader>b", function() require("fzf-lua").buffers() end },
      { "<leader>k", function() require("fzf-lua").help_tags() end },
      { "<leader>u", function() require("fzf-lua").undotree() end },
      { "<leader>gl", function() require("fzf-lua").git_commits() end },
      {
        "<leader>F",
        function()
          if vim.b.bundler_paths == nil then
            return
          end

          require("fzf-lua").live_grep {
            cwd = vim.b.bundler_paths[1]:match("(.*/).-$"),
            search_paths = vim.b.bundler_paths,
          }
        end,
      },
    },
  },
}
