<!-- markdownlint-disable MD041 -->
# Chapter 5 — Copilot in the IDE and CLI

*Part II — GH-300 track: Working with GitHub Copilot*

---

## In 30 seconds

- **The core idea**: Copilot meets you where you work — inline suggestions and chat in the IDE, and a
  dedicated CLI in the terminal, plus Agent Mode for multi-step tasks.
- **Why it matters**: knowing which surface to use, and how to enable it, is core day-to-day fluency.
- **The exam angle**: GH-300 tests **enabling Copilot in the IDE**, **triggering it via inline suggestions,
  chat, CLI, and agent mode**, and the **GitHub Copilot CLI** (install, commands, interactive sessions,
  script/file generation).
- **Remember**: inline = completions; chat = conversation; CLI = terminal; Agent Mode = multi-step tasks.

---

## Exam map

**Exam map — GH-300 · Use GitHub Copilot features (IDE + CLI)**

---

## 1. Key concepts

Copilot is not one feature; it is a set of surfaces you reach for depending on the job. GH-300 devotes its
largest skill area (25–30%) to using those features. This chapter covers the two you live in most — the
**IDE** and the **command line** — and Chapter 6 covers the advanced capabilities layered on top.

> 📌 **Key concept**: match the surface to the task. **Inline suggestions** for completing code as you
> type; **Copilot Chat** for a conversation about code; **agent mode** for multi-step changes across files;
> the **CLI** to work from your terminal.

### Enabling Copilot in the IDE

Copilot runs in editors such as Visual Studio Code, Visual Studio, JetBrains IDEs, Eclipse, Xcode, and
others, via an official extension. Getting started is consistent: install the Copilot extension for your
IDE, sign in with the GitHub account that has a Copilot plan, and confirm the extension is enabled. Once
active, Copilot offers **inline suggestions** (ghost text you accept with <kbd>Tab</kbd>) and opens
**Copilot Chat** in a side panel.

> 📖 **Definition — Inline suggestion**: grey "ghost text" Copilot proposes at your cursor as you type,
> which you accept, dismiss, or cycle through alternatives for. It is the completion experience — fast, in
> the flow, driven by surrounding context (Chapter 2).

### The four ways to trigger Copilot

- **Inline suggestions** — accept completions as you type.
- **Chat** — ask questions and request changes conversationally, with slash commands (`/explain`, `/fix`,
  `/tests`) and context references (`#file`, `#selection`).
- **CLI** — run Copilot as an agent in your terminal (below).
- **Agent mode** — let Copilot plan and apply multi-step, multi-file changes (Chapter 6).

---

## 2. How it works

### GitHub Copilot CLI: an agent in your terminal

> 📖 **Definition — GitHub Copilot CLI**: a command-line tool that brings a Copilot **agent** into your
> terminal. You can ask it questions, have it write and debug code, run tasks on your behalf, and interact
> with GitHub.com — for example, create a branch, open a pull request, or triage issues — without leaving
> the shell. It runs on Linux, macOS, and Windows (PowerShell or WSL).

> 🖥️ **Hands-on**: after installing the CLI, start an interactive session from a project folder and let it
> work with you. Verify current install steps in GitHub Docs.
>
> ```bash
> copilot                       # start an interactive session (asks you to trust the folder)
> # then, at the prompt:
> #   "Add a Node script user-info.js that prints the current user, and open a PR"
> ```

**Two interfaces.** The CLI has an **interactive** mode (you converse, steer, and approve actions) and a
**programmatic** mode for one-shot or scripted use with `-p`/`--prompt`:

```bash
# Programmatic: run one task and exit
copilot -p "Show me this week's commits and summarize them" --allow-tool='shell(git)'

# Pipe options or context from a script
./script-outputting-options.sh | copilot
```

**Interactive niceties** (verify in docs, as they evolve):

- **Plan mode** — press <kbd>Shift</kbd>+<kbd>Tab</kbd> to have Copilot build a structured plan before it
  writes code, so you catch misunderstandings early.
- **Reference a file** with `@path/to/file` to add its contents as context.
- **Run a shell command directly** by prefixing with `!` (for example, `!git status`) — no model call.
- **Manage context** with `/context`, `/compact`, and `/usage`; sessions auto-compact near the token limit.
- **Resume** a session with `copilot --continue` or `/resume`.
- **Schedule** prompts with `/every` and `/after`.

> 🔍 **How it works**: because the CLI can modify and execute files, it asks for **approval** before
> running tools that touch your system. You can approve per-command, for the session, or pre-authorize
> specific tools with flags like `--allow-tool='shell(git)'` (and deny with `--deny-tool`). `--allow-all`
> (or `--yolo`) removes prompts entirely — powerful and risky. Only launch the CLI from **trusted
> directories**.

> ⚠️ **Pitfall**: `--allow-all-tools` / `--yolo` gives Copilot the same access you have to run shell
> commands without review. Use sandboxing (`/sandbox enable`, or `copilot --cloud`) for unattended runs.

### Generating scripts and managing files

A core CLI use case is turning intent into shell work: "write a script that compresses logs older than seven
days," "explain this `tar` command," "revert the last commit leaving changes unstaged," or "create a GitHub
Actions workflow that runs ESLint on pull requests and fails on errors." Copilot proposes the commands or
files, and — with your approval — runs or writes them.

---

## 3. In the real world

**Scenario — one task, three surfaces.** A developer is implementing a feature. She starts with **inline
suggestions**, accepting completions for boilerplate. A tricky bug appears, so she selects the function and
asks **Copilot Chat** `/fix #selection` for an explanation and a patch. Finally, she needs to wire up CI:
rather than context-switch to the browser, she opens the **CLI** and prompts, "branch off main and add a
GitHub Actions workflow that runs the tests on PRs; push it and open a pull request." The CLI plans the
change, asks approval before pushing, and creates the PR with her as author — all without leaving the
terminal.

---

## 4. Exam tips

> 🎯 **Exam tip**: know the **four triggers** — inline suggestions, chat, CLI, and agent mode — and which
> fits which task. "Complete this line" → inline; "explain/refactor this" → chat; "do a multi-step task in
> my terminal" → CLI; "apply a multi-file change" → agent mode.

> 🎯 **Exam tip**: the CLI is an **agent** that can act on your behalf (edit files, run commands, open PRs)
> and therefore asks for **approval**. Recognize the approval model and that you should run it from trusted
> directories.

> 🎯 **Exam tip**: to enable Copilot in an IDE you install the **extension** and **sign in** with an
> account that has a Copilot plan — no model training or server setup is involved.

---

## 5. Common pitfalls

> ⚠️ **Pitfall**: confusing the CLI with plain chat. The modern GitHub Copilot CLI is an **agent** that can
> execute commands and modify files — not just answer questions.

- **Running the CLI from an untrusted or home directory**: it may read/modify files below that location.
  Launch from the specific project folder you trust.
- **Blanket auto-approval**: `--allow-all`/`--yolo` is convenient but removes your review step; prefer
  scoped `--allow-tool` or sandboxing.
- **Assuming inline = chat**: inline completes code silently; chat is conversational with commands and
  references.

---

## 6. Practice questions

**1.** A developer wants Copilot to create a branch, add a file, and open a pull request — all from the
terminal. Which surface is designed for this?

- A. Inline suggestions
- B. GitHub Copilot CLI
- C. The syntax highlighter
- D. A `.gitignore` file

<details markdown="1"><summary>Answer</summary>

**Correct: B.** The Copilot CLI is a terminal agent that can modify files and interact with GitHub.com,
including opening PRs. Inline suggestions (A) only complete code; C and D are unrelated.

</details>

**2.** What must you do to start using Copilot's inline suggestions in your IDE?

- A. Retrain the model on your repository.
- B. Install the Copilot extension and sign in with an account that has a Copilot plan.
- C. Configure a proxy server manually.
- D. Disable all other extensions.

<details markdown="1"><summary>Answer</summary>

**Correct: B.** Enabling Copilot is install-and-sign-in. A, C, and D describe things that are not required.

</details>

**3.** In the Copilot CLI, what does the `--allow-all-tools` (or `--yolo`) option do?

- A. Restricts Copilot to read-only access.
- B. Lets Copilot use any tool and run shell commands without asking for approval.
- C. Enables inline suggestions in the IDE.
- D. Doubles the context window.

<details markdown="1"><summary>Answer</summary>

**Correct: B.** It removes the per-tool approval prompts, granting broad execution power — convenient but
risky. A is the opposite; C and D are unrelated.

</details>

**4.** Which CLI capability lets Copilot build a structured implementation plan before writing any code?

- A. Plan mode
- B. Inline mode
- C. The `!` shell prefix
- D. The duplication filter

<details markdown="1"><summary>Answer</summary>

**Correct: A.** Plan mode has Copilot analyze the request and produce a plan first. The `!` prefix (C) runs
a shell command directly; B and D are unrelated.

</details>

**5.** A developer selects a buggy function and wants Copilot to explain and fix just that code in the IDE.
What is the most direct approach?

- A. Accept the next inline suggestion.
- B. In Copilot Chat, use `/fix` with `#selection` to scope the request to the selected code.
- C. Reinstall the IDE.
- D. Open the CLI and run `--yolo`.

<details markdown="1"><summary>Answer</summary>

**Correct: B.** Chat with a slash command and an explicit selection reference targets exactly that code. A
is unfocused; C is irrelevant; D is an unscoped, risky terminal action.

</details>

---

## Further reading

- **Chapter 6 — Copilot Capabilities**: agent mode, Copilot Edits, MCP, code review, and reuse via
  instructions and prompt files.
- **Chapter 3 — Prompt Engineering & Context Crafting**: slash commands and context references in chat.

> 🔗 **Source**: [About GitHub Copilot CLI (GitHub Docs)](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)

> 🔗 **Source**: [Using GitHub Copilot CLI (GitHub Docs)](https://docs.github.com/copilot/how-tos/use-copilot-agents/use-copilot-cli)
