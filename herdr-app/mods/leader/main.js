// WezTerm-style leader. Lives in a floating block at the bottom of the layout (layouts/main-wsl.json),
// empty until ctrl-f sends `leader.toggle`; then it takes the keyboard, the next key runs one action,
// and focus goes back to the pane you were in. Esc, an unbound key or clicking elsewhere closes it.
import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, hc, theme, focused, spaces, nextCommand } from "herdr";

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

const keysTo = (key) => {
  const t = focused()?.terminal;
  if (t) hc(["keys", t, key]).catch(() => {});
};

// [keys, label, action]. Return true from an action to keep the popup open (it closes itself).
const BINDINGS = [
  [["h"], "pane ←", () => run("pane.go", { direction: "left" })],
  [["j"], "pane ↓", () => run("pane.go", { direction: "down" })],
  [["k"], "pane ↑", () => run("pane.go", { direction: "up" })],
  [["l"], "pane →", () => run("pane.go", { direction: "right" })],
  [["v"], "split right", () => run("pane.split", { direction: "right" })],
  [["s"], "split down", () => run("pane.split", { direction: "down" })],
  [["z"], "zoom", () => run("pane.zoom")],
  [["x"], "close pane", () => run("pane.close")],
  [["c"], "new tab", null], // handled in pick(): needs a timer
  [["n"], "next tab", () => run("tab.next")],
  [["p"], "prev tab", () => run("tab.prev")],
  [[","], "rename tab", () => run("tab.rename")],
  [["{", "shift-["], "move tab ←", () => moveTab(-1)],
  [["}", "shift-]"], "move tab →", () => moveTab(1)],
  [["ctrl-l"], "clear", () => keysTo("ctrl+l")],
  [["ctrl-f"], "send ctrl-f", () => keysTo("ctrl+f")],
];

export default class Leader extends View {
  init(_props, cx) {
    this.h = cx.focus_handle();
    this.open = false;
    cx.spawn(async (cx) => {
      for (;;) {
        const c = await nextCommand();
        if (c === "toggle") this.open ? this.close(true) : this.show(cx);
        cx.notify();
      }
    });
  }

  show(cx) {
    this.prev = focused()?.pane ?? null;
    this.open = true;
    this.hadFocus = false;
    this.h.focus();
    cx.timer.after(30, (cx) => { if (this.open) this.h.focus(); cx.notify(); });
  }

  // restore: give the keyboard back to the pane that had it
  close(restore) {
    this.open = false;
    if (restore && this.prev) run("pane.focus", { pane: this.prev });
  }

  pick(e, cx) {
    cx.stop_propagation();
    if (e.key === "escape") { this.close(true); return cx.notify(); }
    const ks = e.keystroke;
    const ch = e.key_char;
    const b = BINDINGS.find(([keys]) => keys.includes(ks) || (ch && !e.modifiers.control && keys.includes(ch)));
    if (!b) {
      // shift/ctrl alone shouldn't dismiss; anything else unbound does
      if (["shift", "control", "alt", "platform", "function"].includes(e.key)) return;
      this.close(true);
      return cx.notify();
    }
    if (b[0][0] === "c") {
      // WezTerm's leader-c: new tab right after the current one
      this.close(true);
      const { tab } = curTab();
      run("tab.new");
      cx.timer.after(150, () => {
        const now = curTab();
        if (tab && now.tab && now.tab.id !== tab.id && now.tab.index !== tab.index + 1) {
          run("tab.move", { id: now.tab.id, index: tab.index + 1 });
        }
      });
      return cx.notify();
    }
    this.close(true);
    b[2]();
    cx.notify();
  }

  render() {
    if (!this.open) return div();
    // clicked elsewhere: the keyboard left us, so go away (focus is already where they clicked)
    if (this.h.is_focused()) this.hadFocus = true;
    else if (this.hadFocus) { this.open = false; return div(); }
    const t = theme();
    const label = (keys) => keys[0].startsWith("ctrl-") ? "^" + keys[0].slice(5).toUpperCase() : keys[0];
    // Herdr draws the floating frame (background, border, corners); this is only the content.
    return v_flex()
      .id("leader")
      .track_focus(this.h)
      .on_key_down((e, cx) => this.pick(e, cx))
      .w(528)
      .px(6)
      .py(4)
      .gap(8)
      .text_size(12)
      .child(
        h_flex().items_center()
          .child(div().flex_1().font_semibold().text_color(t.accent).child("ctrl-f"))
          .child(div().text_size(11).text_color(t.dim).child("Esc")))
      .child(
        h_flex().flex_wrap().gap_x(14).gap_y(5).children(
          BINDINGS.map(([keys, name]) =>
            h_flex().gap(6).items_center().w(116)
              .child(div().min_w(20).px(5).rounded(4).bg(t.raised).text_color(t.foreground).font_semibold().child(label(keys)))
              .child(div().text_color(t.muted).truncate().child(name)))));
  }
}
