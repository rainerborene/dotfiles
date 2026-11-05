-- Neovim only notices outside changes on :checktime, so watch each file with
-- inotify and check as soon as it changes, even while we stay in the buffer.
-- Doesn't fire for files on /mnt/c (WSL doesn't relay inotify events from Windows).
local M = {}

local watchers = {}

function M.unwatch(buf)
  local w = watchers[buf]
  if w then
    w.handle:stop()
    w.handle:close()
    w.timer:stop()
    w.timer:close()
    watchers[buf] = nil
  end
end

function M.watch(buf)
  M.unwatch(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" or vim.bo[buf].buftype ~= "" or not vim.uv.fs_stat(path) then
    return
  end

  local handle = assert(vim.uv.new_fs_event())
  local timer = assert(vim.uv.new_timer())
  local ok = handle:start(path, {}, function()
    -- debounce: a save is often several events (truncate + write, or delete + create),
    -- and checking mid-way would see the file as deleted
    timer:stop()
    timer:start(100, 0, vim.schedule_wrap(function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return M.unwatch(buf)
      end
      if vim.fn.getcmdwintype() == "" then
        vim.cmd.checktime(buf)
      end
      -- an atomic save (write temp + rename) replaces the inode we were watching
      if vim.api.nvim_buf_is_valid(buf) then
        M.watch(buf)
      end
    end))
  end)
  if not ok then
    handle:close()
    timer:close()
    return
  end
  watchers[buf] = { handle = handle, timer = timer }
end

return M
