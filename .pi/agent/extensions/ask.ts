/**
 * Ask User Tool Extension
 *
 * Registers an `ask_user` tool that lets the agent open a polished interactive
 * question dialog in Pi's TUI. Use it when the agent needs a preference,
 * clarification, or decision before continuing. The dialog supports 1-4 questions,
 * 2-4 options per question, optional multi-select, previews, and a custom "Other"
 * answer.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Editor, Key, matchesKey, truncateToWidth, wrapTextWithAnsi, Text } from "@earendil-works/pi-tui";
import { Type, type Static } from "typebox";

const OptionSchema = Type.Object({
  label: Type.String({ description: "Short option label. Put the recommended option first and append (Recommended)." }),
  description: Type.String({ description: "One-line explanation of the option." }),
  preview: Type.Optional(Type.String({ description: "Optional markdown/text preview shown when this option is highlighted." })),
});

const QuestionSchema = Type.Object({
  question: Type.String({ description: "Full question to ask the user." }),
  header: Type.String({ description: "Short chip/tab label, e.g. Scope, Database, Style." }),
  options: Type.Array(OptionSchema, { minItems: 2, maxItems: 4, description: "Two to four answer options." }),
  multiSelect: Type.Optional(Type.Boolean({ description: "Allow selecting multiple options." })),
});

const AskUserQuestionParams = Type.Object({
  questions: Type.Array(QuestionSchema, { minItems: 1, maxItems: 4, description: "One to four questions for the user." }),
});

type AskUserQuestionParams = Static<typeof AskUserQuestionParams>;
type Question = AskUserQuestionParams["questions"][number];
type Option = Question["options"][number] & { isOther?: boolean };

type AskResult = {
  questions: AskUserQuestionParams["questions"];
  answers: Record<string, string>;
  cancelled: boolean;
};

const GUIDELINES = [
  "Use ask_user when you need user preferences, clarification, or a decision before continuing.",
  "Do not bury important questions in prose; call ask_user with a structured questions array instead.",
  "ask_user supports 1-4 questions, each with 2-4 options and optional multiSelect. Users can always choose Other and type their own answer.",
  "For ask_user, put the recommended option first and append (Recommended) to its label when one choice is best.",
];

const OTHER_OPTION: Option = { label: "Other", description: "Type a custom answer.", isOther: true };

function validate(params: AskUserQuestionParams): string | undefined {
  if (params.questions.length < 1 || params.questions.length > 4) return "Ask 1 to 4 questions.";

  const questions = new Set<string>();
  for (const q of params.questions) {
    if (questions.has(q.question)) return `Duplicate question: ${q.question}`;
    questions.add(q.question);
    if (q.options.length < 2 || q.options.length > 4) return `Question '${q.header}' needs 2 to 4 options.`;

    const labels = new Set<string>();
    for (const opt of q.options) {
      if (labels.has(opt.label)) return `Duplicate option '${opt.label}' in ${q.header}.`;
      labels.add(opt.label);
    }
  }
}

const cancelledResult = (params: AskUserQuestionParams): AskResult => ({
  questions: params.questions,
  answers: {},
  cancelled: true,
});

export default function ask(pi: ExtensionAPI) {
  pi.registerTool({
    name: "ask_user",
    label: "Ask User",
    description: "Open a polished interactive UI to ask the user one to four structured questions with answer options.",
    promptSnippet: "Ask the user structured clarification/decision questions in a polished interactive popup.",
    promptGuidelines: GUIDELINES,
    parameters: AskUserQuestionParams,

    async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
      const error = validate(params);
      if (error) {
        return { content: [{ type: "text", text: `Invalid ask_user input: ${error}` }], details: cancelledResult(params) };
      }
      if (!ctx.hasUI) {
        return { content: [{ type: "text", text: "Cannot ask questions: no interactive UI is available." }], details: cancelledResult(params) };
      }

      const result = await ctx.ui.custom<AskResult>((tui, theme, _kb, done) => {
        let tab = 0;
        let optionIndex = 0;
        let editMode = false;
        let cached: string[] | undefined;

        const answers = new Map<string, string>();
        const selected = new Map<string, Set<string>>();
        const lastTab = params.questions.length;
        const editor = new Editor(tui, {
          borderColor: (s) => theme.fg("accent", s),
          selectList: {
            selectedPrefix: (s) => theme.fg("accent", s),
            selectedText: (s) => theme.fg("accent", s),
            description: (s) => theme.fg("muted", s),
            scrollInfo: (s) => theme.fg("dim", s),
            noMatch: (s) => theme.fg("warning", s),
          },
        });

        const refresh = () => { cached = undefined; tui.requestRender(); };
        const q = () => params.questions[tab];
        const opts = (): Option[] => [...q().options, OTHER_OPTION];
        const answered = (question: Question) => answers.has(question.question);
        const allAnswered = () => params.questions.every(answered);
        const finish = (cancelled: boolean) => done({ questions: params.questions, answers: Object.fromEntries(answers), cancelled });
        const setTab = (next: number) => { tab = (next + lastTab + 1) % (lastTab + 1); optionIndex = 0; refresh(); };
        const save = (question: Question, answer: string) => answers.set(question.question, answer);
        const advance = () => params.questions.length === 1 ? finish(false) : setTab(allAnswered() ? lastTab : Math.min(tab + 1, lastTab));
        const enterCustomAnswer = () => { editMode = true; refresh(); };

        editor.onSubmit = (value) => {
          const text = value.trim();
          if (text) save(q(), text);
          editMode = false;
          editor.setText("");
          advance();
        };

        function chooseOption() {
          const question = q();
          const option = opts()[optionIndex];
          if (option.isOther) return enterCustomAnswer();
          save(question, option.label);
          advance();
        }

        function toggleOption() {
          const question = q();
          const option = opts()[optionIndex];
          if (option.isOther) return enterCustomAnswer();

          const set = selected.get(question.question) ?? new Set<string>();
          set.has(option.label) ? set.delete(option.label) : set.add(option.label);
          selected.set(question.question, set);
          set.size ? save(question, [...set].join(", ")) : answers.delete(question.question);
          refresh();
        }

        function handleInput(data: string) {
          if (editMode) {
            if (matchesKey(data, Key.escape)) { editMode = false; editor.setText(""); refresh(); return; }
            editor.handleInput(data); refresh(); return;
          }

          if (matchesKey(data, Key.escape)) return finish(true);
          if (matchesKey(data, Key.tab) || matchesKey(data, Key.right)) return setTab(tab + 1);
          if (matchesKey(data, Key.shift("tab")) || matchesKey(data, Key.left)) return setTab(tab - 1);

          if (tab === lastTab) {
            if (matchesKey(data, Key.enter) && allAnswered()) finish(false);
            return;
          }

          const options = opts();
          if (matchesKey(data, Key.up)) { optionIndex = Math.max(0, optionIndex - 1); refresh(); return; }
          if (matchesKey(data, Key.down)) { optionIndex = Math.min(options.length - 1, optionIndex + 1); refresh(); return; }
          if (matchesKey(data, Key.space) && q().multiSelect) return toggleOption();
          if (matchesKey(data, Key.enter)) return q().multiSelect ? answered(q()) && advance() : chooseOption();
        }

        function render(width: number): string[] {
          if (cached) return cached;

          const lines: string[] = [];
          const add = (s = "") => lines.push(truncateToWidth(s, width));
          const rule = theme.fg("accent", "─".repeat(Math.max(1, width)));

          add(rule);
          if (params.questions.length > 1) renderTabs(add);
          add();
          tab === lastTab ? renderReview(add) : renderQuestion(add, width);
          add();
          add(theme.fg("dim", tab === lastTab ? " ←/Tab navigate • Enter submit • Esc cancel" : " ↑↓ select • Enter choose/continue • Space toggle multi-select • Tab switch • Esc cancel"));
          add(rule);

          cached = lines;
          return lines;
        }

        function renderTabs(add: (s?: string) => void) {
          const questionTabs = params.questions.map((question, i) => {
            const done = answered(question);
            const text = ` ${done ? "●" : "○"} ${question.header} `;
            if (i === tab) return theme.bg("selectedBg", theme.fg("text", text));
            return theme.fg(done ? "success" : "muted", text);
          });
          const submitTab = tab === lastTab ? theme.bg("selectedBg", theme.fg("text", " ✓ Submit ")) : theme.fg(allAnswered() ? "success" : "dim", " ✓ Submit ");
          add(` ${questionTabs.join(" ")} ${submitTab}`);
        }

        function renderReview(add: (s?: string) => void) {
          add(theme.fg("accent", " Review answers")); add();
          for (const question of params.questions) add(` ${theme.fg("muted", question.header + ":")} ${answers.get(question.question) ?? theme.fg("warning", "unanswered")}`);
          add();
          add(allAnswered() ? theme.fg("success", " Press Enter to send answers") : theme.fg("warning", " Answer all questions first"));
        }

        function renderQuestion(add: (s?: string) => void, width: number) {
          const question = q();
          const options = opts();

          for (const line of wrapTextWithAnsi(theme.fg("text", question.question), Math.max(10, width - 2))) add(` ${line}`);
          add();

          options.forEach((option, i) => renderOption(add, question, option, i));
          renderPreview(add, width, options[optionIndex]?.preview);
          if (editMode) renderEditor(add, width);
        }

        function renderOption(add: (s?: string) => void, question: Question, option: Option, i: number) {
          const active = i === optionIndex;
          const checked = selected.get(question.question)?.has(option.label);
          const box = question.multiSelect ? (checked ? "☑" : "☐") : `${i + 1}.`;
          add(`${active ? theme.fg("accent", " ❯") : "  "} ${theme.fg(active ? "accent" : "text", `${box} ${option.label}`)}`);
          add(`      ${theme.fg("muted", option.description)}`);
        }

        function renderPreview(add: (s?: string) => void, width: number, preview?: string) {
          if (!preview) return;
          add(); add(theme.fg("borderMuted", " ┌─ Preview"));
          for (const line of wrapTextWithAnsi(theme.fg("dim", preview), Math.max(10, width - 4)).slice(0, 8)) add(` │ ${line}`);
        }

        function renderEditor(add: (s?: string) => void, width: number) {
          add(); add(theme.fg("muted", " Custom answer:"));
          for (const line of editor.render(width - 2)) add(` ${line}`);
        }

        return { render, invalidate: () => { cached = undefined; }, handleInput };
      });

      if (result.cancelled) {
        return { content: [{ type: "text", text: "User cancelled answering the questions." }], details: result };
      }
      const text = Object.entries(result.answers).map(([q, a]) => `"${q}"="${a}"`).join("; ");
      return { content: [{ type: "text", text: `User has answered your questions: ${text}. Continue with these answers in mind.` }], details: result };
    },

    renderCall(args, theme) {
      const qs = Array.isArray(args.questions) ? args.questions : [];
      return new Text(`${theme.fg("toolTitle", theme.bold("ask_user"))} ${theme.fg("muted", `${qs.length} question${qs.length === 1 ? "" : "s"}`)}`, 0, 0);
    },

    renderResult(result, _options, theme) {
      const details = result.details as AskResult | undefined;
      if (!details) return new Text("", 0, 0);
      if (details.cancelled) return new Text(theme.fg("warning", "Question dialog cancelled"), 0, 0);
      return new Text(Object.entries(details.answers).map(([q, a]) => `${theme.fg("success", "✓")} ${theme.fg("muted", q)} → ${theme.fg("accent", a)}`).join("\n"), 0, 0);
    },
  });
}
