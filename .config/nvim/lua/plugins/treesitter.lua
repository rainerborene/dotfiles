return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
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
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if not vim.treesitter.get_parser(nil, nil, { error = false }) then
            return
          end

          vim.treesitter.start()
          if vim.bo.filetype ~= "yaml" then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        desc = "Temporary solution to address the Ruby indentation issue",
        callback = function()
          vim.opt_local.indentkeys:remove "."
        end,
      })

      require("nvim-treesitter").install(opts.ensure_installed)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ["@function.outer"] = "V",
          ["@block.outer"] = "V",
          ["@class.outer"] = "V",
        },
      },
    },
    keys = {
      {
        "af",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        desc = "Select outer function",
        mode = { "x", "o" },
      },
      {
        "if",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        desc = "Select inner function",
        mode = { "x", "o" },
      },
      {
        "am",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        desc = "Select outer class",
        mode = { "x", "o" },
      },
      {
        "im",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        desc = "Select inner class",
        mode = { "x", "o" },
      },
      {
        "ar",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
        end,
        desc = "Select block outer",
        mode = { "x", "o" },
      },
      {
        "ir",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
        end,
        desc = "Select block inner",
        mode = { "x", "o" },
      },
    },
  },
}
