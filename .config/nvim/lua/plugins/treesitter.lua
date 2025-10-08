return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "ruby",
      "json",
      "lua",
      "html",
      "javascript",
      "typescript",
      "sql",
      "tsx",
      "query",
      "vue",
      "vim",
      "caddy",
      "vimdoc",
      "css",
    },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["am"] = "@class.outer",
          ["im"] = "@class.inner",
          ["ar"] = "@block.outer",
          ["ir"] = "@block.inner",
        },
        selection_modes = {
          ["@function.outer"] = "V",
          ["@block.outer"] = "V",
          ["@class.outer"] = "V",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  },
  config = function(_, opts)
    local toggle_inc_selection_group = vim.api.nvim_create_augroup("plugin_toggle_inc_selection", { clear = true })

    vim.api.nvim_create_autocmd("CmdwinEnter", {
      desc = "Disable incremental selection when entering the cmdline window",
      group = toggle_inc_selection_group,
      command = "TSBufDisable incremental_selection",
    })

    vim.api.nvim_create_autocmd("CmdwinLeave", {
      desc = "Enable incremental selection when leaving the cmdline window",
      group = toggle_inc_selection_group,
      command = "TSBufEnable incremental_selection",
    })

    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      desc = "Temporary solution to address the Ruby indentation issue",
      callback = function()
        vim.opt_local.indentkeys:remove "."
      end,
    })

    require("nvim-treesitter.configs").setup(opts)
  end,
}
