return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      -- Herdr's "graphite" palette on top of Catppuccin's highlight rules.
      -- Graphite has 6 hues + brights; the extra Catppuccin names borrow the nearest one.
      color_overrides = {
        mocha = {
          -- backgrounds and greys
          base = "#17191d",
          mantle = "#131518",
          crust = "#101114",
          surface0 = "#2c2e31",
          surface1 = "#3c3f45",
          surface2 = "#4f5259",
          overlay0 = "#696a6d",
          overlay1 = "#818793",
          overlay2 = "#98999b",
          subtext0 = "#adaeb0",
          subtext1 = "#c4c6ca",
          text = "#d2d4d9",
          -- hues (normal, then bright variants for the extra names)
          red = "#dc8c95",
          maroon = "#f0a5ad",
          flamingo = "#f0a5ad",
          rosewater = "#f0f0f2",
          peach = "#ead2a1",
          yellow = "#d8be87",
          green = "#a6bd91",
          teal = "#8cbdc3",
          sky = "#a4d5db",
          sapphire = "#b0cbef",
          blue = "#96b2d7",
          lavender = "#b0cbef",
          mauve = "#b5a2ce",
          pink = "#cbb7e6",
        },
      },
      auto_integrations = true,
      custom_highlights = function()
        return {
          htmlTagN = { link = "htmlTagName" },
          SlimLine = { link = "StatusLine" },
          MatchWord = { bold = true },
          Visual = { bg = "#394454" }, -- graphite's selection
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)

      vim.cmd.colorscheme "catppuccin-nvim"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = {
        theme = "catppuccin-nvim",
        -- rounded: pill-shaped sections, rounded caps at both ends
        section_separators = { left = "", right = "" },
        component_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" } } },
        lualine_b = { "branch" },
        lualine_z = { { "location", separator = { left = "", right = "" } } },
      },
    },
    config = function(_, opts)
      local pill = { left = "", right = "" }

      -- built-in extensions replace our sections, dropping the pill caps on a/z;
      -- wrap them so their outer sections get the same rounded ends
      local function rounded(name)
        local ext = vim.deepcopy(require("lualine.extensions." .. name))
        for _, key in ipairs { "sections", "inactive_sections" } do
          for _, sec in ipairs { "lualine_a", "lualine_z" } do
            local comps = ext[key] and ext[key][sec]
            for i, c in ipairs(comps or {}) do
              if type(c) ~= "table" then c = { c } end
              c.separator = c.separator or pill
              comps[i] = c
            end
          end
        end
        return ext
      end

      opts.extensions = vim.tbl_map(rounded, { "fugitive", "lazy", "oil" })
      require("lualine").setup(opts)
    end,
  },
  {
    "mhinz/vim-startify",
    init = function()
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_session_persistence = 1
    end,
  },
}
