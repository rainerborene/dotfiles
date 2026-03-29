return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      auto_integrations = true,
      custom_highlights = function()
        return {
          htmlTagN = { link = "htmlTagName" },
          SlimLine = { link = "StatusLine" },
          MatchWord = { bold = true },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme "catppuccin-nvim"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin-nvim",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
      },
    },
  },
  {
    "mhinz/vim-startify",
    init = function()
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_session_persistence = 1
    end,
  },
}
