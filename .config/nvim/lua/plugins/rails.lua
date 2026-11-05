return {
  {
    "tpope/vim-bundler",
    event = "VeryLazy",
  },
  {
    "tpope/vim-rails",
    init = function()
      -- -- Save ~1s loading ruby file
      vim.g.ruby_host_prog = "~/.local/share/mise/installs/ruby/latest/bin/neovim-ruby-host"

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

      vim.api.nvim_create_autocmd("User", {
        pattern = "Rails",
        group = vim.api.nvim_create_augroup("plugin_rails", { clear = true }),
        callback = function(event)
          vim.api.nvim_buf_create_user_command(event.buf, "AV", function(args)
            local alternate = vim.fn.eval "rails#buffer().alternate()"
            if vim.fn.filereadable(alternate) == 1 or args.bang then
              vim.cmd.vsplit(alternate)
            end
          end, {
            bang = true,
            bar = true,
          })
        end,
      })
    end,
  },
  {
    "janko-m/vim-test",
    init = function()
      local herdr = require "rainer.herdr_test"
      vim.g["test#custom_strategies"] = { herdr = herdr.strategy }
      vim.g["test#strategy"] = herdr.name()
    end,
    keys = {
      { "<leader>rr", "<cmd>TestNearest<cr>" },
      { "<leader>rf", "<cmd>TestFile<cr>" },
      { "<leader>ra", "<cmd>TestSuite<cr>" },
      { "<leader>rl", "<cmd>TestLast<cr>" },
      { "<leader>rg", "<cmd>TestVisit<cr>" },
    },
  },
}
