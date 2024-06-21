local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"
local npairs = require "nvim-autopairs"

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local function small_3f(buf)
  local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
  return (byte_size < (1024 * 1024))
end

local function get_bufnrs()
  local visible_bufs = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if small_3f(buf) then
      visible_bufs[buf] = true
    end
  end
  return vim.tbl_keys(visible_bufs)
end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load { paths = "~/.config/nvim/snippets" }
require("luasnip").filetype_extend("ruby", { "rails" })

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-l>"] = cmp.mapping.close(),
    ["<C-e>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = get_bufnrs,
      },
    },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = {
        nvim_lsp = "[LSP]",
        buffer = "[Buf]",
        vsnip = "[Snip]",
        path = "[Path]",
      },
    },
  },
}

npairs.setup()

npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")

-- https://github.com/L3MON4D3/LuaSnip/issues/656
local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = unlinkgrp,
  pattern = { "s:n", "i:*" },
  desc = "Forget the current snippet when leaving the insert mode",
  callback = function(evt)
    if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})
