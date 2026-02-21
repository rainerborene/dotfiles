return {
  {
    "Saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
      },
      keymap = {
        preset = "super-tab",
        ["<C-e>"] = { "select_and_accept", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      },
      cmdline = {
        enabled = false,
      },
      signature = {
        enabled = true,
      },
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
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            score_offset = 3,
            opts = {
              extended_filetypes = {
                ruby = { "rails" },
              },
            },
          },
          buffer = {
            opts = {
              get_bufnrs = vim.api.nvim_list_bufs,
            },
          },
        },
      },
    },
    init = function()
      vim.g.omni_sql_no_default_maps = 1
    end
  },
}
