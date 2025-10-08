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
          before_init = function(_, new_config)
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
                globals = { "vim", "require", "Snacks" },
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
          before_init = function(_, new_config)
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
        },
      },
    },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      vim.diagnostic.config { virtual_text = true }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("plugin_lsp", { clear = true }),
        callback = function(event)
          local map = function(lhs, rhs, map_opts)
            vim.keymap.set(map_opts.mode or "n", lhs, rhs, { buffer = event.buf, silent = true, desc = map_opts.desc })
          end

          map("<leader>ld", vim.lsp.buf.definition, { desc = "Go to Definition" })
          map("<leader>li", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
          map("<leader>le", vim.lsp.buf.references, { desc = "Find references" })
          map("<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
          map("<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
          map("<leader>ll", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
          map("<leader>ls", function()
            vim.lsp.buf.signature_help { border = "rounded" }
          end, { desc = "Show signature help" })
          map("K", function()
            vim.lsp.buf.hover { border = "rounded" }
          end, { desc = "Hover documentation" })
        end,
      })
    end,
  },
}
