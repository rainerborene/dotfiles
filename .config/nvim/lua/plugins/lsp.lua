return {
  { "b0o/schemastore.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = {
      servers = {
        ruby_lsp = {},
        ts_ls = {},
        emmet_language_server = {
          filetypes = { "css", "eruby", "html", "vue" },
        },
        tailwindcss = {
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
            new_config.settings.editor = { tabSize = vim.lsp.util.get_effective_tabstop() }
            new_config.settings.tailwindCSS.experimental.configFile =
              unpack(vim.fs.find("tailwind.application.js", { type = "file" }))
          end,
        },
        lua_ls = {
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
        },
        jsonls = {
          settings = {
            json = {
              schemas = {},
              validate = { enable = true },
            },
          },
          on_new_config = function(new_config)
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
        },
      },
    },
    config = function(_, opts)
      local lspconfig = require "lspconfig"
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.diagnostic.config { virtual_text = true }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("plugin_lsp", { clear = true }),
        callback = function(event)
          local map = function(lhs, rhs, mode)
            mode = mode or "n"
            vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, silent = true })
          end

          map("<leader>ld", vim.lsp.buf.definition)
          map("<leader>li", vim.lsp.buf.implementation)
          map("<leader>le", vim.lsp.buf.references)
          map("<leader>lr", vim.lsp.buf.rename)
          map("<leader>la", vim.lsp.buf.code_action)
          map("<leader>ll", vim.diagnostic.open_float)
          map("<leader>ls", function()
            vim.lsp.buf.signature_help { border = "rounded" }
          end)
          map("K", function()
            vim.lsp.buf.hover { border = "rounded" }
          end)
        end,
      })
    end,
  },
}
