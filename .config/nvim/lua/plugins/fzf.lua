return {
  "ibhagwan/fzf-lua",
  lazy = false,
  config = function()
    local actions = require("fzf-lua").actions

    require("fzf-lua").setup {
      { "borderless-full" },

      defaults = {
        prompt = " 🐺 ",
      },

      fzf_opts = {
        ["--info"] = "default",
        ["--cycle"] = false,
        ["--layout"] = "default",
        ["--pointer"] = " ",
        ["--gutter"] = " ",
      },

      fzf_colors = {
        ["fg"] = { "fg", "NormalFloat" },
        ["bg"] = { "bg", "NormalFloat" },
        ["scrollbar"] = { "bg", "NormalFloat" },
        ["info"] = { "fg", "EndOfBuffer" },
        ["separator"] = { "bg", "NormalFloat" },
        ["header"] = { "fg", "Comment" },
      },

      hls = {
        border = "NormalFloat",
        preview_border = "NormalFloat",
        title = "PmenuSel",
        preview_title = "PmenuExtra",
        header_bind = "Comment",
        header_text = "Comment",
      },

      winopts = {
        title_pos = "left",
        preview = {
          scrollbar = false,
          title_pos = "left",
          winopts = {
            number = false,
          },
        },
      },

      keymap = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          true,
          ["ctrl-d"] = "preview-page-down",
          ["ctrl-u"] = "preview-page-up",
          ["ctrl-q"] = "select-all+accept",
        },
      },

      actions = {
        files = {
          ["enter"] = actions.file_edit_or_qf,
          ["ctrl-x"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["alt-q"] = actions.file_sel_to_qf,
        },
      },

      files = {
        cwd_prompt = false,
      },

      buffers = {
        keymap = { builtin = { ["<C-d>"] = false } },
        actions = { ["ctrl-x"] = false, ["ctrl-d"] = { fn = actions.buf_del, reload = true } },
      },

      grep = {
        hidden = true,
      },

      git = {
        commits = {
          cmd = [[git log --color --pretty=format:"%C(yellow)%h%Creset %C(blue)%ad%Creset ]]
            .. [[%s %C(black)<%an>%Creset" --date=format:"%a %H:%M"]],

          preview_pager = function()
            return vim.fn.executable "delta" == 1
                and ("delta --commit-decoration-style='' --file-style=omit --hunk-header-decoration-style='black ul' --width=%s --%s"):format(
                  vim.fn.executable "$COLUMNS" == 1 and "$COLUMNS" or "80",
                  vim.o.bg
                )
              or nil
          end,

          actions = {
            ["ctrl-d"] = false,
            ["enter"] = function(line, _)
              vim.cmd.DiffviewOpen(line[1]:match "[^ ]+" .. "^!")
            end,
          },
        },
      },
    }
  end,

  -- stylua: ignore
  keys = {
    { "z=", function() require("fzf-lua").spell_suggest() end },
    { "<leader><leader>", function() require("fzf-lua").files() end },
    { "<leader><tab>", function() require("fzf-lua").keymaps() end },
    { "<leader>a", function() require("fzf-lua").live_grep() end },
    { "<leader>A", function() require("fzf-lua").grep_cword() end },
    { "<leader>b", function() require("fzf-lua").buffers() end },
    { "<leader>k", function() require("fzf-lua").help_tags() end },
    { "<leader>u", function() require("fzf-lua").undotree() end },
    { "<leader>gl", function() require("fzf-lua").git_commits() end },
    {
      "<leader>F",
      function()
        if vim.b.bundler_paths == nil then
          return
        end

        require("fzf-lua").live_grep {
          cwd = vim.b.bundler_paths[1]:match("(.*/).-$"),
          search_paths = vim.b.bundler_paths,
        }
      end,
    },
  },
}
