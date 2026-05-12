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
}
