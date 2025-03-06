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
  on_new_config = function(new_config)
    local default_config = lspconfig.tailwindcss.config_def.default_config
    local tw_config_file = vim.fs.find("tailwind.application.js", { type = "file" })

    default_config.on_new_config(new_config)

    new_config.settings.tailwindCSS.experimental.configFile = unpack(tw_config_file)
  end,
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
