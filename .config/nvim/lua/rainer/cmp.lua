local cmp = require('cmp')
local lspkind = require('lspkind')
local npairs = require('nvim-autopairs')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
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

local escape = function()
  if cmp.visible() then
    cmp.mapping.close()
  end
  feedkey('<esc>', 'i')
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['jj'] = cmp.mapping(escape),
    ['<C-c>'] = cmp.mapping(escape),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' })
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'tags' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = get_bufnrs
      },
    },
    { name = 'vsnip' },
    { name = 'tmux' },
    { name = 'path' }
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = '[LSP]',
        tags = '[Tag]',
        buffer = '[Buf]',
        vsnip = '[Snip]',
        tmux = '[Tmux]',
        path = '[Path]'
      }
    },
  }
}

npairs.setup()

npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
