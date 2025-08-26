require("blink.cmp").setup {
  appearance = {
    use_nvim_cmp_as_default = true,
  },
  keymap = {
    preset = "super-tab",
    ["<C-e>"] = { "select_and_accept", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },
  cmdline = {
    enabled = false,
  },
  signature = { enabled = true },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = {
        border = "rounded",
      },
    },
    list = {
      selection = {
        preselect = function()
          return not require("blink.cmp").snippet_active { direction = 1 }
        end,
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
    providers = {
      snippets = {
        score_offset = 3,
      },
      buffer = {
        opts = {
          get_bufnrs = vim.api.nvim_list_bufs,
        },
      },
      ripgrep = {
        name = "Ripgrep",
        module = "blink-ripgrep",
        score_offset = -3,
        async = true,
        timeout_ms = 100,
        opts = {
          backend = {
            ripgrep = {
              max_filesize = "100K",
            },
          },
        },
      },
    },
  },
}

-- Forget the current snippet when leaving the insert mode
vim.keymap.set({ "i", "s" }, "<Esc>", function()
  vim.snippet.stop()
  return "<Esc>"
end, { expr = true })
