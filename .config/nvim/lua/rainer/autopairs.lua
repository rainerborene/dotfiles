local npairs = require "nvim-autopairs"

npairs.setup {
  disable_filetype = { "TelescopePrompt", "snacks_picker_input", "grug-far" },
}

npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
npairs.add_rules(require "nvim-autopairs.rules.endwise-ruby")
