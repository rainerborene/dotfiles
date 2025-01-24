---@diagnostic disable-next-line: undefined-field
require("codecompanion").setup {
  strategies = {
    chat = {
      adapter = "openai",
    },
    inline = {
      adapter = "openai",
    },
  },
}
