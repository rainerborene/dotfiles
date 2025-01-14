---@diagnostic disable: missing-fields

require("blink.cmp").setup {
  appearance = {
    use_nvim_cmp_as_default = true,
  },
  keymap = {
    preset = "super-tab",
    ["<C-e>"] = { "select_and_accept" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    cmdline = {
      preset = "super-tab",
      ["<C-d>"] = { "show" },
    },
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
      },
    },
  },
}

-- Inspired by https://github.com/L3MON4D3/LuaSnip/issues/656
vim.api.nvim_create_autocmd("ModeChanged", {
  group = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true }),
  pattern = { "s:n", "i:*" },
  desc = "Forget the current snippet when leaving the insert mode",
  callback = function()
    vim.snippet.stop()
  end,
})
