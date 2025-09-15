return {
  { "b0o/schemastore.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require "lspconfig"

      lspconfig.ruby_lsp.setup {}
      lspconfig.ts_ls.setup {}
      lspconfig.emmet_language_server.setup {
        filetypes = { "css", "eruby", "html", "vue" },
      }

      lspconfig.tailwindcss.setup {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { [[(?:["'])((?:(?!["']|<%=).|<%=.*?%>)*)(?:["'])]] },
              },
            },
          },
        },
        on_new_config = function(new_config)
          local default_config = lspconfig.tailwindcss.config_def.default_config
          local tw_config_file = vim.fs.find("tailwind.application.js", { type = "file" })

          default_config.on_new_config(new_config)

          new_config.settings.tailwindCSS.experimental.configFile = unpack(tw_config_file)
        end,
      }

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.jsonls.setup {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      }
    end,
    keys = {
      { "<leader>ld", vim.lsp.buf.definition },
      { "<leader>li", vim.lsp.buf.implementation },
      { "<leader>ls", vim.lsp.buf.signature_help },
      { "<leader>le", vim.lsp.buf.references },
      { "<leader>lr", vim.lsp.buf.rename },
      { "<leader>lh", vim.lsp.buf.hover },
      { "<leader>la", vim.lsp.buf.code_action },
      { "<leader>ll", vim.lsp.diagnostic.show_line_diagnostics },
    },
  },
}
