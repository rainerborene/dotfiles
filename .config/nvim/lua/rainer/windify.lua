local config_files = {}
local current_config_file = nil

local function get_config_files_async()
  vim.system({ "fd", "tailwind.*.js" }, {
    text = true,
    stderr = function(_, err)
      if err then
        vim.notify("Error running `fd`: " .. err, vim.log.levels.ERROR)
      end
    end,
    stdout = function(_, data)
      if not data then
        return
      end
      config_files = vim.split(data, "\n", { trimempty = true })
      current_config_file = config_files[1]
    end,
  })
end

vim.api.nvim_create_user_command("TwConfig", function(opts)
  if #config_files == 0 then
    vim.notify("No configuration files found.", vim.log.levels.ERROR)
    return
  end

  if opts.args == "" then
    print(current_config_file or "No current configuration file set.")
  else
    current_config_file = opts.args
  end
end, {
  nargs = "?",
  complete = function()
    return config_files
  end,
})

vim.api.nvim_create_user_command("Tw", function()
  vim.cmd.write()
  vim.system({
    vim.fn.expand "~/.dotfiles/bin/windify",
    vim.fn.expand "%:p",
    current_config_file,
  }, {
    env = {
      NODE_PATH = vim.loop.cwd() .. "/node_modules",
    },
    stderr = function(_, data)
      if data then
        vim.notify(data, vim.log.levels.WARN)
      end
    end,
  }, function()
    vim.schedule(function()
      vim.cmd.checktime()
    end)
  end)
end, {
  nargs = 0,
})

-- Run, forest, run!
get_config_files_async()
