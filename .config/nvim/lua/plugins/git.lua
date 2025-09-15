return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "▁" },
        topdelete = { text = "▔" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("v", "<leader>hs", function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end)
        map("v", "<leader>hr", function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end)
        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)
        map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end)
        map("n", "<leader>hd", gitsigns.diffthis)
        map("n", "<leader>hD", function() gitsigns.diffthis "~" end)
        map("n", "<leader>hQ", function() gitsigns.setqflist "all" end)
        map("n", "<leader>hq", gitsigns.setqflist)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
        map("n", "<leader>tw", gitsigns.toggle_word_diff)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>ge", ":Gedit<cr>" },
      { "<leader>gl", ":Gclog<cr>" },
      { "<leader>gw", ":Gwrite<cr>" },
      { "<leader>gs", ":Git<cr>gg)", remap = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gitcommit", "git" },
        group = vim.api.nvim_create_augroup("plugin_fugitive", { clear = true }),
        callback = function()
          vim.opt_local.foldmethod = "syntax"
          vim.opt_local.spell = true
        end,
      })
    end,
  },
  {
    "junegunn/gv.vim",
    cmd = "GV",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = { use_icons = false },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "DiffviewFiles" },
        group = vim.api.nvim_create_augroup("plugin_diffview", { clear = true }),
        callback = function(event)
          vim.keymap.set("n", "q", ":DiffviewClose<cr>", { buffer = event.buf, silent = true })
        end,
      })
    end,
    keys = {
      {
        "<leader>gd",
        function()
          if vim.t.diffview_view_initialized then
            return vim.cmd.DiffviewClose()
          end
          return vim.cmd.DiffviewOpen()
        end,
      },
    },
  },
}
