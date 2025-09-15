return {
  {
    "tpope/vim-bundler",
    event = "VeryLazy",
  },
  {
    "tpope/vim-rails",
    event = "VeryLazy",
    init = function()
      vim.g.rails_projections = {
        ["app/components/*_component.rb"] = {
          command = "component",
          template = { "class {camelcase|capitalize|colons}Component < ApplicationComponent", "end" },
          related = "app/components/{}_component.html.erb",
        },
        ["app/components/*_component.html.erb"] = {
          related = "app/components/{}_component.rb",
          alternate = "test/components/{}_component_test.rb",
        },
      }
    end,
  },
  {
    "janko-m/vim-test",
    init = function()
      vim.g["test#strategy"] = "wezterm"
    end,
    keys = {
      { "<leader>rr", ":TestNearest" },
      { "<leader>rf", ":TestFile" },
      { "<leader>ra", ":TestSuite" },
      { "<leader>rl", ":TestLast" },
      { "<leader>rg", ":TestVisit" },
    },
  },
}
