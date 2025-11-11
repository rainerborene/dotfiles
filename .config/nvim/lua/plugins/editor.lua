return {
  { "tpope/vim-unimpaired" },

  { "tpope/vim-repeat" },

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
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
    end,
    keys = {
      { "<leader>u", "<Cmd>UndotreeToggle<cr>" },
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
        "M",
        function()
          require("flash").treesitter_search()
        end,
      },
      {
        "<c-j>",
        function()
          require("flash").toggle()
        end,
        mode = "c",
      },
      {
        "<cr>",
        function()
          require("flash").treesitter {
            actions = {
              ["<cr>"] = "next",
              ["<bs>"] = "prev",
            },
          }
        end,
        mode = { "n", "x", "o" },
        ft = { "ruby", "json", "lua", "html", "javascript", "typescript", "tsx", "vue", "vim", "css" }
      }
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      scope = { enabled = true },
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
    },
    keys = {
      { "ai", mode = { "o", "x" } },
      { "ii", mode = { "o", "x" } },
      { "<leader><leader>", function() Snacks.picker.files() end, },
      { "<leader><tab>", function() Snacks.picker.keymaps() end, },
      { "<leader>.", function() Snacks.picker.lsp_workspace_symbols() end, },
      { "<leader>k", function() Snacks.picker.help() end, },
      { "<leader>b", function() Snacks.picker.buffers() end, },
      { "<leader>a", function() Snacks.picker.grep() end, },
      { "<leader>A", function() Snacks.picker.grep_word() end, mode = { "n", "v" }, },
      { "<leader>f", function() Snacks.picker.grep_word { search = vim.fn.input "Grep For > ", regex = true } end, },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log {
            follow = true,
            current_file = vim.v.count > 0,
            confirm = function(picker, item, action)
              picker:close()
              if not item then
                return
              end
              if not action.cmd then
                vim.cmd.DiffviewOpen(item.commit .. "^!")
              elseif action.cmd == "split" then
                vim.cmd.Gsplit(item.commit)
              elseif action.cmd == "vsplit" then
                vim.cmd.Gvsplit(item.commit)
              elseif action.cmd == "tab" then
                vim.cmd.Gtabedit(item.commit)
              end
            end,
          }
        end,
      },
      {
        "<leader>F",
        function()
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
      },
    },
  },
}
