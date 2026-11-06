// Commands for keys.json that Herdr has no single command for. The ctrl-f sequences themselves live
// in keys.json; this mod sits in an empty floating block (layouts/main-wsl.json) only so it can
// receive `leader.<command>` from nextCommand().
import { View, div } from "gpui-kit";
import { run, focused, spaces, panes, nextCommand } from "herdr";

const curTab = () => {
  const f = focused();
  const sp = spaces().find((s) => s.id === f?.space);
  return { f, sp, tab: sp?.tabs.find((t) => t.id === f?.tab) };
};

const moveTab = (delta) => {
  const { sp, tab } = curTab();
  if (!sp || !tab) return;
  const to = Math.min(Math.max(tab.index + delta, 1), sp.tabs.length);
  if (to !== tab.index) run("tab.move", { id: tab.id, index: to });
};

const until = async (cx, ok) => {
  for (let i = 0; i < 40 && !ok(); i++) await new Promise((r) => cx.timer.after(50, () => r()));
  return ok();
};

// ctrl-f !: move the pane into a new tab of its own (WezTerm's move_to_new_tab). Herdr has no
// command for it: park the terminal (its pane goes, the program keeps running), then keep it
// without a place, which gives it a pane in a new tab.
const hasPane = (terminal) => panes().some((p) => p.terminal === terminal);
const paneToTab = async (me, cx) => {
  if (!me?.pane || !me.terminal) return;
  const mine = panes().find((p) => p.pane === me.pane);
  if (!panes().some((p) => p.tab === mine?.tab && p.pane !== me.pane)) return; // already alone
  run("terminal.park", { terminal: me.terminal });
  if (!(await until(cx, () => !hasPane(me.terminal)))) return;
  run("terminal.keep", { terminal: me.terminal });
  if (!(await until(cx, () => hasPane(me.terminal)))) return;
  // Herdr names a kept terminal's tab after its address ("wsl/t12"); go back to a plain number
  const tab = panes().find((p) => p.terminal === me.terminal)?.tab;
  if (tab) run("tab.rename", { id: tab, name: "" });
  run("pane.focus", { terminal: me.terminal });
};

export default class Leader extends View {
  init(_props, cx) {
    cx.spawn(async (cx) => {
      for (;;) {
        const c = await nextCommand();
        if (c === "tab-left") moveTab(-1);
        else if (c === "tab-right") moveTab(1);
        else if (c === "pane-to-tab") await paneToTab(focused(), cx);
      }
    });
  }

  render() {
    return div();
  }
}
