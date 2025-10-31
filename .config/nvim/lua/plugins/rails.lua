return {
  {
    "tpope/vim-bundler",
    event = "VeryLazy",
  },
  {
    "tpope/vim-rails",
    init = function()
      -- Save ~1s loading ruby file
      local lib_ruby_dir = "~/.asdf/installs/ruby/3.4.7/lib/ruby"
      vim.g.ruby_host_prog = "~/.asdf/shims/neovim-ruby-host"
      vim.g.ruby_default_path = {
        lib_ruby_dir .. "/3.4.0",
        lib_ruby_dir .. "/3.4.0/x86_64-linux",
        lib_ruby_dir .. "/site_ruby",
        lib_ruby_dir .. "/site_ruby/3.4.0",
        lib_ruby_dir .. "/site_ruby/3.4.0/x86_64-linux",
        lib_ruby_dir .. "/vendor_ruby",
        lib_ruby_dir .. "/vendor_ruby/3.4.0",
        lib_ruby_dir .. "/vendor_ruby/3.4.0/x86_64-linux",
      }

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
      vim.g["test#strategy"] = "wezterm"
    end,
    keys = {
      {
        "<leader>rr",
        function()
          vim.g["test#wezterm#pane_id"] = nil
          vim.cmd.TestNearest()
        end,
      },
      { "<leader>rf", ":TestFile<cr>" },
      { "<leader>ra", ":TestSuite<cr>" },
      { "<leader>rl", ":TestLast<cr>" },
      { "<leader>rg", ":TestVisit<cr>" },
    },
  },
}
