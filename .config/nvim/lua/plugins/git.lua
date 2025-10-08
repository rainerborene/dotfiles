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
        end, { desc = "Jump to next git [c]hange" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git [s]tage hunk" })

        map("v", "<leader>hr", function()
          gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git [r]eset hunk" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis "@"
        end, { desc = "git [D]iff against last commit" })

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
        map({ "o", "x" }, "ah", gitsigns.select_hunk)
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gread", "Gwrite" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gitcommit", "git" },
        group = vim.api.nvim_create_augroup("plugin_git", { clear = true }),
        callback = function()
          vim.schedule(function()
            vim.opt_local.foldmethod = "syntax"
            vim.opt_local.spell = true
          end)
        end,
      })
    end,
    keys = {
      { "<leader>ge", ":Gedit<cr>" },
      { "<leader>gw", ":Gwrite<cr>" },
      { "<leader>gs", ":Git<cr>gg)", remap = true },
    },
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
