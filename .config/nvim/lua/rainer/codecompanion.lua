---@diagnostic disable-next-line: undefined-field
require("codecompanion").setup {
  strategies = {
    chat = {
      adapter = "openai",
    },
    inline = {
      adapter = "openai",
      keymaps = {
        accept_change = {
          modes = { n = "<localleader>a" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "<localleader>r" },
          description = "Reject the suggested change",
        },
      },
    },
  },
}
