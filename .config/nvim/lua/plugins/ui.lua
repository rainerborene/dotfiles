return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"

      vim.api.nvim_set_hl(0, "Slimline", { link = "StatusLine" })
      vim.api.nvim_set_hl(0, "MatchWord", { bold = true })
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
