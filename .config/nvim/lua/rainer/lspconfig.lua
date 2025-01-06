local capabilities = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require "lspconfig"

lspconfig.ruby_lsp.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.emmet_language_server.setup {
  capabilities = capabilities,
  filetypes = { "css", "eruby", "html", "vue" },
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { [[(?:["'])((?:(?!["']|<%=).|<%=.*?%>)*)(?:["'])]] },
        },
      },
    },
  },
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
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
