return {
  "ibhagwan/fzf-lua",
  lazy = false,
  config = function()
    local actions = require("fzf-lua").actions

    -- Herdr-style picker: a floating popover with rounded corners, the prompt on top,
    -- matches in Herdr's accent blue (graphite palette, as in Herdr's "Go to…" picker).
    local c = {
      popover = "#25272b", -- Herdr's popover: a step lighter than the editor
      border = "#393b3f", -- Herdr's hairline border over the popover
      selected = "#34363a",
      text = "#d2d4d9",
      bright = "#eeeeef",
      muted = "#98999b",
      dim = "#696a6d",
      accent = "#96b2d7",
      accent_bright = "#b0cbef",
      green = "#a6bd91",
    }
    local function set_hls()
      local hl = vim.api.nvim_set_hl
      hl(0, "FzfLuaNormal", { fg = c.text, bg = c.popover })
      hl(0, "FzfLuaBorder", { fg = c.border, bg = c.popover })
      hl(0, "FzfLuaTitle", { fg = c.muted, bg = c.popover, bold = true })
      hl(0, "FzfLuaPreviewNormal", { fg = c.text, bg = c.popover })
      hl(0, "FzfLuaPreviewBorder", { fg = c.border, bg = c.popover })
      hl(0, "FzfLuaPreviewTitle", { fg = c.muted, bg = c.popover })
      hl(0, "FzfLuaCursorLine", { bg = c.selected })
      hl(0, "FzfLuaHeaderBind", { fg = c.dim })
      hl(0, "FzfLuaHeaderText", { fg = c.dim })
    end
    set_hls()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })

    require("fzf-lua").setup {
      { "default-title" },

      defaults = {
        prompt = "› ",
      },

      fzf_opts = {
        ["--info"] = "inline-right",
        ["--cycle"] = false,
        ["--layout"] = "reverse",
        ["--pointer"] = "▌",
        ["--marker"] = "▌",
        ["--gutter"] = " ",
        ["--separator"] = "─",
        ["--scrollbar"] = "│",
      },

      fzf_colors = {
        ["fg"] = c.text,
        ["bg"] = c.popover,
        ["fg+"] = c.bright,
        ["bg+"] = c.selected,
        ["gutter"] = c.popover,
        ["hl"] = c.accent,
        ["hl+"] = c.accent_bright,
        ["query"] = c.bright,
        ["prompt"] = c.accent,
        ["pointer"] = c.accent,
        ["marker"] = c.green,
        ["info"] = c.dim,
        ["spinner"] = c.dim,
        ["separator"] = c.border,
        ["scrollbar"] = c.border,
        ["border"] = c.border,
        ["header"] = c.dim,
      },

      hls = {
        normal = "FzfLuaNormal",
        border = "FzfLuaBorder",
        title = "FzfLuaTitle",
        preview_normal = "FzfLuaPreviewNormal",
        preview_border = "FzfLuaPreviewBorder",
        preview_title = "FzfLuaPreviewTitle",
        cursorline = "FzfLuaCursorLine",
        header_bind = "FzfLuaHeaderBind",
        header_text = "FzfLuaHeaderText",
      },

      winopts = {
        height = 0.8,
        width = 0.85,
        row = 0.4,
        col = 0.5,
        border = "rounded",
        backdrop = false, -- Herdr's popups don't dim what's behind them
        title_pos = "left",
        title_flags = false,
        preview = {
          border = "rounded",
          layout = "flex",
          flip_columns = 140,
          horizontal = "right:55%",
          vertical = "down:50%",
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
        actions = {
          ["ctrl-x"] = false,
          ["ctrl-k"] = { fn = actions.buf_del, reload = true },
        },
      },

      grep = {
        hidden = true,
        -- Text after ` --` in the live grep query is split into tokens:
        -- tokens starting with `-` become rg options (e.g. `--pcre2`),
        -- everything else becomes an `--iglob` like the default behavior.
        rg_glob_fn = function(query, opts)
          local search, rest = query:match("(.-)" .. opts.glob_separator .. "(.*)")
          local args = {}
          for _, tok in ipairs(vim.split(rest or "", "%s+", { trimempty = true })) do
            if tok:sub(1, 1) == "-" then
              table.insert(args, vim.fn.shellescape(tok))
            else
              table.insert(args, opts.glob_flag .. " " .. vim.fn.shellescape(tok))
            end
          end
          return search or "", table.concat(args, " ")
        end,
      },

      git = {
        branches = {
          actions = {
            ["enter"] = function(selected)
              local fzf = require "fzf-lua"
              local branch = selected[1]:match "%s-[%+%*]?%s+([^ ]+)"
              fzf.git_commits { cmd = fzf.config.globals.git.commits.cmd .. " " .. branch }
            end,
          },
        },

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
    { "<leader>gL", function() require("fzf-lua").git_bcommits() end },
    { "<leader>gb", function() require("fzf-lua").git_branches() end },
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
