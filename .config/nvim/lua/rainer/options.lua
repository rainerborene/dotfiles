-- misc
vim.opt.confirm = true
vim.opt.shortmess:append "c"
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.spellfile = vim.fn.stdpath "config" .. "/spell/custom-dictionary.utf-8.add"
vim.opt.spelllang:append "pt"
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wildignore = { "*.DS_Store", "*~", ".git", "*.pyc", "*.o", "*.spl", "*.rdb" }

-- text manipulation
vim.opt.expandtab = true
vim.opt.formatoptions = "qrn1j"
vim.opt.linebreak = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.textwidth = 80
vim.opt.virtualedit = "block"
vim.opt.completeopt = { "noinsert", "menuone", "noselect" }
vim.schedule(function ()
  vim.opt.clipboard = "unnamedplus"
end)

-- folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.require('rainer.utils').fold_text()"

-- better navigation
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ui customization
vim.opt.list = true
vim.opt.diffopt:append "algorithm:patience"
vim.opt.listchars = { tab = "» ", trail = "·", extends = "❯", precedes = "❮" }
vim.opt.fillchars = { diff = "─", vert = "│", msgsep = "─" }
vim.opt.showbreak = "↪ "
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.pumheight = 20
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- disable optional providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
