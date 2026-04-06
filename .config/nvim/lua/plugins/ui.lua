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
    init = function()
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = {
        theme = "catppuccin-nvim",
        section_separators = "",
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_b = { "branch" },
      },
      extensions = { "fugitive", "lazy", "oil" },
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
