return {
  {
    "AndrewRadev/switch.vim",
    init = function()
      vim.g.switch_mapping = "-"
    end,
    keys = { "-" },
  },
  {
    "AndrewRadev/sideways.vim",
    keys = {
      { "sh", ":SidewaysLeft<cr>" },
      { "sl", ":SidewaysRight<cr>" },
      { "aa", "<Plug>SidewaysArgumentTextobjA", mode = { "o", "x" } },
      { "ia", "<Plug>SidewaysArgumentTextobjI", mode = { "o", "x" } },
    },
  },

  { "folke/ts-comments.nvim" },

  { "tpope/vim-rsi" },

  { "kana/vim-niceblock" },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "snacks_picker_input", "snacks_picker_list", "grug-far" },
    },
    config = function(_, opts)
      local npairs = require "nvim-autopairs"

      npairs.setup(opts)
      npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
      npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")
    end,
  },
  {
    "andymass/vim-matchup",
    init = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "sa",
        normal_line = "saa",
        normal_cur_line = "sS",
        visual = "s",
        delete = "sd",
        change = "sr",
      },
      surrounds = {
        ["E"] = {
          add = { "<%= ", " %>" },
          find = function()
            return require("nvim-surround.config").get_selection { pattern = "<%%=.-%%>" }
          end,
          delete = "^(<%%=%s*)().-(%s*%%>)()$",
        },
      },
    },
  },
  {
    "coderifous/textobj-word-column.vim",
    init = function()
      vim.g.skip_default_textobj_word_column_mappings = 1
    end,
    keys = {
      { "av", [[:<C-u>call TextObjWordBasedColumn("aw")<cr>]], mode = { "x", "o" }, silent = true },
      { "aV", [[:<C-u>call TextObjWordBasedColumn("aW")<cr>]], mode = { "x", "o" }, silent = true },
      { "iv", [[:<C-u>call TextObjWordBasedColumn("iw")<cr>]], mode = { "x", "o" }, silent = true },
      { "iV", [[:<C-u>call TextObjWordBasedColumn("iW")<cr>]], mode = { "x", "o" }, silent = true },
    },
  },
}
