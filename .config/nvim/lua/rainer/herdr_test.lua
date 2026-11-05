-- vim-test strategy for the Herdr app: tests run in a shell pane split below nvim.
-- The first run splits nvim's own pane and remembers the new terminal; later runs type the
-- command into it with `hc send`. Herdr splits 50/50 and has no size option, so drag the
-- divider once; the pane (and its size) is reused until you close it.
local M = {}

-- `herdr-app` on PATH (in WSL: a symlink ~/.local/bin/herdr-app to the Windows .exe); HERDR_APP_EXE overrides.
local exe = vim.env.HERDR_APP_EXE or "herdr-app"
local state = { terminal = nil } -- Herdr's address of the test terminal, e.g. "wsl/t12"

local function run(cmd, timeout)
  local ok, res = pcall(function()
    return vim.system(cmd, { text = true, timeout = timeout or 3000 }):wait()
  end)
  if not ok or res.code ~= 0 then
    return nil
  end
  return res.stdout
end

local function herdr(args)
  local out = run(vim.list_extend({ exe }, args))
  local ok, json = pcall(vim.json.decode, out or "")
  return ok and json or nil
end

-- Herdr addresses remote terminals as "<machine>/t12"; hc inside WSL wants plain "t12".
local function local_id(address)
  return address:match "([^/]+)$"
end

local function alive(address)
  local out = run { "hc", "get", local_id(address), "--json" }
  local ok, json = pcall(vim.json.decode, out or "")
  return ok and json.state == "live"
end

-- nvim's own pane, found by its terminal (HC_TERMINAL_ID), so splitting never depends on focus.
local function own_pane()
  local id = vim.env.HC_TERMINAL_ID
  local ls = id and herdr { "ls" }
  for _, space in ipairs(ls and ls.spaces or {}) do
    for _, tab in ipairs(space.tabs) do
      for _, t in ipairs(tab.terminals) do
        if local_id(t.terminal) == id then
          return t.pane
        end
      end
    end
  end
end

local function notify(msg)
  vim.notify(msg, vim.log.levels.WARN, { title = "vim-test (herdr)" })
end

function M.strategy(cmd)
  if state.terminal and alive(state.terminal) then
    vim.system { "hc", "send", local_id(state.terminal), cmd } -- async: nvim doesn't wait
    return
  end

  local pane = own_pane()
  if not pane then
    return notify "can't find nvim's Herdr pane; is this a Herdr terminal?"
  end
  local made = herdr { "do", "pane.split", "--direction", "down", "--pane", pane }
  if not (made and made.terminal) then
    return notify "pane.split failed"
  end
  state.terminal = made.terminal
  herdr { "do", "pane.focus", "--pane", pane } -- keep typing in nvim
  local full = ("cd %s && %s"):format(vim.fn.shellescape(vim.fn.getcwd()), cmd)
  vim.system { "hc", "send", local_id(made.terminal), full }
end

-- Inside a Herdr terminal use the Herdr pane; anywhere else, vim-test's own nvim terminal.
function M.name()
  return vim.env.HC_TERMINAL_ID and vim.fn.executable(exe) == 1 and "herdr" or "neovim"
end

return M
