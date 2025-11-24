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
        "svelte",
      },
      indent = {
        enable = true,
        disable = { "yaml", "ruby" },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local filetype = args.match
          local lang = vim.treesitter.language.get_lang(filetype)
          ---@diagnostic disable-next-line: param-type-mismatch
          if not vim.treesitter.language.add(lang) then
            return
          end
          vim.treesitter.start()
          if opts.indent.enable and not vim.tbl_contains(opts.indent.disable, vim.bo.filetype) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
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
