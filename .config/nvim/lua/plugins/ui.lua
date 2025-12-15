return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      auto_integrations = true,
      custom_highlights = function()
        return {
          SlimLine = { link = "StatusLine" },
          MatchWord = { bold = true },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    "sschleemilch/slimline.nvim",
    opts = {
      style = "fg",
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
