local config = require "nvim-surround.config"

require("nvim-surround").setup {
  keymaps = { -- vim-surround style keymaps
    insert = false, -- "<C-s>",
    insert_line = false, -- "<C-s><C-s>",
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
        return config.get_selection { pattern = "<%%=.-%%>" }
      end,
      delete = "^(<%%=%s*)().-(%s*%%>)()$",
    },
  },
}
