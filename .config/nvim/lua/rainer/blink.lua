---@diagnostic disable: missing-fields

require("blink.cmp").setup {
  appearance = {
    use_nvim_cmp_as_default = true,
  },
  keymap = {
    preset = "super-tab",
    ["<C-e>"] = { "select_and_accept" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
  },
  cmdline = {
    enabled = false,
  },
  signature = { enabled = true },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 50,
      window = {
        border = "rounded",
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
    providers = {
      snippets = {
        score_offset = 3,
      },
      ripgrep = {
        name = "Ripgrep",
        module = "blink-ripgrep",
        score_offset = -3,
        opts = {
          max_filesize = "100K",
          -- future_features = {
          --   issue185_workaround = true,
          -- },
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
