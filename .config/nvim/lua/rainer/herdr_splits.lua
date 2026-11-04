-- smart-splits.nvim v3 backend for the Herdr app (herdr-app + herdr-core).
-- Not the herdr TUI: that one has its own backend, smart-splits-backend-herdr.
-- The Herdr side is the `smart-nav` mod in ~/.config/herdr-app: it sends ctrl/alt-hjkl
-- into panes running nvim, and this backend hands the move back at nvim's edge.

---@class HerdrAppBackend: SmartSplitsBackend
local M = {
  name = "herdr-app",
  protocol_version = "3.0.0",
}

M.config = {
  exe = vim.env.HERDR_APP_EXE or "/mnt/c/Users/Rainer Borene/AppData/Local/Programs/herdr-app/herdr-app.exe",
  timeout = 300,
}

-- herdr-core sets HC_TERMINAL_ID in every terminal it runs.
function M.detect()
  return vim.env.HC_TERMINAL_ID ~= nil and vim.uv.fs_stat(M.config.exe) ~= nil
end

local function herdr(args)
  local ok, res = pcall(function()
    return vim.system(vim.list_extend({ M.config.exe }, args), { text = true, timeout = M.config.timeout }):wait()
  end)
  return ok and res.code == 0
end

-- `pane.go` succeeds at Herdr's edge without moving, so `true` means "asked Herdr".
-- With at_edge = "stop" that's the same result. Herdr can't wrap or split from here.
function M.move(direction, opts)
  opts = opts or {}
  if opts.at_edge == "wrap" or opts.at_edge == "split" then
    return false
  end
  return herdr { "do", "pane.go", "--direction", direction }
end

-- No resize: Herdr has no command to resize a pane.

function M.health()
  if vim.env.HC_TERMINAL_ID == nil then
    vim.health.info "not inside a herdr-core terminal (HC_TERMINAL_ID unset)"
  else
    vim.health.ok("herdr-core terminal " .. vim.env.HC_TERMINAL_ID)
  end
  if vim.uv.fs_stat(M.config.exe) then
    vim.health.ok("herdr-app: " .. M.config.exe)
  else
    vim.health.warn("herdr-app not found at " .. M.config.exe .. " (set $HERDR_APP_EXE)")
  end
end

return M
