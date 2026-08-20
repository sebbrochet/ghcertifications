<!-- markdownlint-disable MD041 -->
# Chapter 15 — GH-300 Exam Readiness

*Part IV — Exam readiness*

---

## In 30 seconds

- **The core idea**: a final, objective-by-objective sweep of GH-300 with a full-length practice exam.
- **Why it matters**: confirms readiness and surfaces weak areas before test day.
- **The exam angle**: a passing score is **700**; skills measured **as of August 7, 2026**.
- **Remember**: features move Preview → GA — verify against the live study guide before booking.

---

## 1. Objective checklist

- [ ] **Use GitHub Copilot responsibly (15–20%)** — risks/limitations; ethical use; harms & mitigations;
      validating output; responsible operation.
- [ ] **Use GitHub Copilot features (25–30%)** — IDE (inline/chat/CLI/agent mode); Copilot CLI; Agent Mode,
      Edits, MCP, sub-agents; code review; Spaces, Spark, PR summaries, instructions files; Chat commands
      and prompt files; org-wide policies, audit logs, REST API subscriptions.
- [ ] **Understand data and architecture (10–15%)** — data flow/sharing; prompt building; proxy filtering;
      post-processing; suggestion lifecycle; LLM/Copilot limitations.
- [ ] **Prompt engineering and context crafting (10–15%)** — structure/context; zero-shot/few-shot; best
      practices; process flow and chat history.
- [ ] **Improve developer productivity (10–15%)** — generation/refactoring/docs; tests/edge cases/
      assertions; security and performance; sample data; legacy modernization.
- [ ] **Privacy, content exclusions, and safeguards (10–15%)** — content exclusions; output ownership;
      public-code filtering; troubleshooting.

---

## 2. High-yield facts

Memorize these before test day. Each is a compact, frequently tested fact from Chapters 1–8.

- **Passing score is 700.** GH-300 skills are measured **as of August 7, 2026**. Most questions cover GA
  features; some commonly used Preview features may appear.
- **Two Copilots.** GitHub Copilot (developer) ≠ Microsoft 365 Copilot (business). Never conflate.
- **LLM limitations:** fabrication (hallucination), knowledge cutoff, non-deterministic output, no
  execution/verification, finite context window.
- **Suggestion lifecycle (order):** context gathering → prompt building → **proxy filtering** → model →
  **post-processing** → suggestion. Filtering happens **around** the model, not inside it.
- **"Neighboring tabs":** related open files feed the context and change suggestions.
- **Data (Business/Enterprise):** prompts and code are used to produce the response and are **not** used to
  train the foundation models.
- **Four triggers:** inline suggestions, Copilot Chat, the CLI, and agent mode.
- **Copilot CLI** is a standalone `copilot` **agent** (can edit files, run commands, open PRs) and asks for
  **approval**; run from **trusted directories**; `--allow-all`/`--yolo` removes prompts.
- **Agent mode vs Copilot Edits:** agent mode *decides* changes and *runs tools to verify*; Copilot Edits
  applies a change *you describe* across multiple files.
- **Instructions files** set standing standards (`.github/copilot-instructions.md`, path-specific
  `*.instructions.md`, `AGENTS.md`); **prompt files** package repeatable requests.
- **Instruction precedence:** personal > repository > organization (all relevant sets still apply). Code
  review reads instructions from the PR **head branch**.
- **MCP** extends Copilot with external tools/data; the **GitHub MCP server** is built in.
- **Prompting:** zero-shot (no example) vs few-shot (with examples); iterate; conversation history carries
  context; reference `#file`/`#selection`.
- **Productivity use cases:** generation, refactoring, docs, tests (edge cases + assertions), sample data,
  legacy modernization, security/performance *suggestions* — always **draft then verify**.
- **Two safeguards:** **content exclusions = input** (what Copilot can see); **duplication (public-code)
  filter = output** (what it can show).
- **Governance:** **policies** set feature availability (IDEs & github.com); **audit logs** answer "who did
  what"; the **REST API** manages seats/subscriptions.
- **Ownership:** you generally **own accepted suggestions** but remain responsible for validation and
  license compliance.
- **Responsible AI principles:** fairness; reliability & safety; privacy & security; inclusiveness;
  transparency; accountability. Accountability stays **human**.

---

## 3. Mock exam (GH-300)

40 questions, weighted roughly by skill area. Answer before expanding each explanation. Target 70%+ before
sitting the real exam.

### Use GitHub Copilot responsibly

**1.** A developer wants to merge Copilot-generated code without review because "the AI wrote it." What is
the responsible action?

- A. Merge it; AI output needs no review.
- B. Require review, testing, and scanning; a human is accountable.
- C. Merge if it compiles.
- D. Ban all AI-generated code.

<details markdown="1"><summary>Answer</summary>

**B.** Validation and human accountability are core to responsible use.

</details>

**2.** Which is a genuine risk when accepting Copilot suggestions?

- A. Suggestions may include insecure patterns learned from training data.
- B. Suggestions always run slower than hand-written code.
- C. Suggestions cannot be edited.
- D. Suggestions disable the compiler.

<details markdown="1"><summary>Answer</summary>

**A.** Models can surface insecure patterns — hence review and scanning.

</details>

**3.** Under the responsible-AI principles, which one explains why a human answers for shipped AI-assisted
code?

- A. Inclusiveness
- B. Accountability
- C. Transparency
- D. Reliability & safety

<details markdown="1"><summary>Answer</summary>

**B.** Accountability assigns responsibility to the human.

</details>

**4.** The single most important step before trusting a suggestion in production is to:

- A. Accept it quickly.
- B. Validate it — understand, test, and scan.
- C. Increase the context window.
- D. Share the prompt publicly.

<details markdown="1"><summary>Answer</summary>

**B.** Validation is the core mitigation for probabilistic output.

</details>

**5.** Which pairing of risk and mitigation is correct?

- A. Sensitive-data exposure → content exclusions and keeping secrets out of prompts
- B. Fabrication → enable dark mode
- C. Insecure code → lower the temperature
- D. IP concerns → delete the repository

<details markdown="1"><summary>Answer</summary>

**A.** Exclusions and prompt hygiene mitigate data exposure.

</details>

**6.** A teammate claims Copilot "understands" your intent and guarantees correct code. This is:

- A. Accurate.
- B. A misconception — Copilot predicts plausible code and can be wrong.
- C. True only in agent mode.
- D. True for Business plans.

<details markdown="1"><summary>Answer</summary>

**B.** The model pattern-matches; it does not understand or guarantee.

</details>

**7.** Which is an appropriate way to operate Copilot responsibly?

- A. Paste production secrets into prompts for context.
- B. Use content exclusions and validate output with tests and scanning.
- C. Accept all suggestions to save time.
- D. Disable code review for speed.

<details markdown="1"><summary>Answer</summary>

**B.** Protect data and validate output.

</details>

### Use GitHub Copilot features

**8.** A developer wants Copilot to create a branch, add a file, and open a PR from the terminal. Which
surface?

- A. Inline suggestions
- B. GitHub Copilot CLI
- C. Syntax highlighter
- D. `.gitignore`

<details markdown="1"><summary>Answer</summary>

**B.** The CLI is a terminal agent that can act on GitHub.com.

</details>

**9.** What must you do to start using Copilot in your IDE?

- A. Retrain the model on your repo.
- B. Install the Copilot extension and sign in with a plan.
- C. Configure a proxy manually.
- D. Disable other extensions.

<details markdown="1"><summary>Answer</summary>

**B.** Install-and-sign-in.

</details>

**10.** In the Copilot CLI, `--allow-all-tools` (or `--yolo`):

- A. Makes Copilot read-only.
- B. Lets Copilot use any tool and run shell commands without approval.
- C. Enables inline suggestions.
- D. Doubles the context window.

<details markdown="1"><summary>Answer</summary>

**B.** It removes per-tool approval — powerful and risky.

</details>

**11.** Which capability plans, edits multiple files, *and runs tools to verify* the change?

- A. Inline suggestions
- B. Copilot Edits
- C. Agent mode
- D. A prompt file

<details markdown="1"><summary>Answer</summary>

**C.** Agent mode decides changes and runs tools (e.g., tests).

</details>

**12.** Where do repository-wide custom instructions live?

- A. `.github/copilot-instructions.md`
- B. `README.md`
- C. `.gitignore`
- D. `package.json`

<details markdown="1"><summary>Answer</summary>

**A.** Repository-wide instructions; path-specific ones live under `.github/instructions/`.

</details>

**13.** The purpose of adding an MCP server to Copilot is to:

- A. Retrain the model.
- B. Extend Copilot with external tools and data via a standard protocol.
- C. Disable filters.
- D. Add license seats.

<details markdown="1"><summary>Answer</summary>

**B.** MCP connects agents to tools/data.

</details>

**14.** When personal, repository, and organization instructions all apply, priority is:

- A. Organization > repository > personal
- B. Personal > repository > organization
- C. Repository only
- D. Organization only

<details markdown="1"><summary>Answer</summary>

**B.** Personal is highest, but all relevant sets still apply.

</details>

**15.** For Copilot code review, custom instructions are read from:

- A. The base branch
- B. The pull request's head branch
- C. A random branch
- D. The default branch only

<details markdown="1"><summary>Answer</summary>

**B.** Head branch — so you can test instruction changes in the same PR.

</details>

**16.** A developer selects a buggy function and wants Copilot to explain and fix just that code. Best
approach?

- A. Accept the next inline suggestion.
- B. In Chat, use `/fix` with `#selection`.
- C. Reinstall the IDE.
- D. Run the CLI with `--yolo`.

<details markdown="1"><summary>Answer</summary>

**B.** Scope the request to the selection with a slash command.

</details>

**17.** What distinguishes an instructions file from a prompt file?

- A. They are identical.
- B. Instructions set standing standards applied automatically; prompt files package repeatable requests.
- C. Prompt files disable agent mode.
- D. Instructions only work in the CLI.

<details markdown="1"><summary>Answer</summary>

**B.** Rules vs repeatable tasks.

</details>

**18.** Which built-in MCP server ships with Copilot?

- A. The GitHub MCP server
- B. A Jira MCP server
- C. No server is built in
- D. A database MCP server

<details markdown="1"><summary>Answer</summary>

**A.** The GitHub MCP server is preconfigured.

</details>

**19.** Why should you launch the Copilot CLI only from trusted directories?

- A. It changes the theme.
- B. It may read, modify, and execute files in and below that directory.
- C. It disables approvals.
- D. It doubles token usage.

<details markdown="1"><summary>Answer</summary>

**B.** The agent can act on local files — trust matters.

</details>

### Understand data and architecture

**20.** The correct order of a Copilot suggestion is:

- A. Model → prompt building → proxy → suggestion
- B. Context gathering → prompt building → proxy filtering → model → post-processing → suggestion
- C. Proxy → model → context gathering → suggestion
- D. Prompt building → model → context gathering → proxy

<details markdown="1"><summary>Answer</summary>

**B.** Filtering surrounds the model.

</details>

**21.** A suggestion resembles code from a file you have open but aren't editing. Why?

- A. Copilot trained on your repo overnight.
- B. The open file was included as neighboring-tab context.
- C. The proxy injected it.
- D. The duplication filter added it.

<details markdown="1"><summary>Answer</summary>

**B.** Related open tabs contribute context.

</details>

**22.** Under Business/Enterprise, your prompts and code are:

- A. Retained to train the foundation models.
- B. Used to generate the response and not used to train the models.
- C. Published publicly.
- D. Shared with other customers.

<details markdown="1"><summary>Answer</summary>

**B.** Not used for training under Business/Enterprise.

</details>

**23.** The public-code match filter is applied:

- A. Inside the model's weights.
- B. In the proxy / post-processing, around the model.
- C. In the editor's highlighter.
- D. During pretraining.

<details markdown="1"><summary>Answer</summary>

**B.** Filtering happens around the model.

</details>

**24.** Which is a real limitation of the model behind Copilot?

- A. It can fabricate plausible but incorrect code.
- B. It guarantees compilation.
- C. It has real-time runtime awareness.
- D. It refuses novel code.

<details markdown="1"><summary>Answer</summary>

**A.** Hallucination is inherent to generation.

</details>

**25.** Why can the same prompt produce different suggestions?

- A. The license changed.
- B. Generation is probabilistic (sampling), so output varies.
- C. The context window doubled.
- D. Copilot is broken.

<details markdown="1"><summary>Answer</summary>

**B.** Non-deterministic sampling.

</details>

### Prompt engineering and context crafting

**26.** You need generated rows to match an exact JSON shape. Best technique?

- A. Zero-shot prompting
- B. Few-shot prompting with example rows
- C. Lowering temperature only
- D. Opening unrelated files

<details markdown="1"><summary>Answer</summary>

**B.** Few-shot pins the format.

</details>

**27.** A first Chat answer misses null handling. Best next step?

- A. Start a new unrelated chat and retype everything.
- B. In the same thread, ask it to handle null/empty inputs and add a test.
- C. Switch languages.
- D. Repeat the prompt verbatim.

<details markdown="1"><summary>Answer</summary>

**B.** Iterate within the thread to reuse context.

</details>

**28.** Referencing `#selection` or a specific `#file` in Chat:

- A. Retrains the model.
- B. Adds that code to the prompt's context to ground the answer.
- C. Disables filtering.
- D. Increases the window size.

<details markdown="1"><summary>Answer</summary>

**B.** Explicit references inject relevant context.

</details>

**29.** "Prompt engineering" for a developer means:

- A. Fine-tuning a model with code.
- B. Crafting clear instructions and supplying context/examples to improve output.
- C. Configuring a proxy.
- D. Training a new LLM.

<details markdown="1"><summary>Answer</summary>

**B.** Instructions, context, examples — no training.

</details>

**30.** Which prompt is most likely to yield correct, well-shaped code?

- A. "Fix this."
- B. "Improve the function."
- C. "Refactor `parseConfig` to return `Result<Config, Error>`, keep the signature, add a test for a malformed file."
- D. "Make it faster somehow."

<details markdown="1"><summary>Answer</summary>

**C.** Intent + specifics + an edge case.

</details>

### Improve developer productivity

**31.** The most appropriate task for Copilot is:

- A. Guaranteeing zero vulnerabilities.
- B. Generating unit tests and edge cases you then review.
- C. Setting your product roadmap.
- D. Certifying code production-ready with no review.

<details markdown="1"><summary>Answer</summary>

**B.** Test generation is a core, well-suited use case.

</details>

**32.** A generated test passes on first run. Before relying on it you should:

- A. Nothing — passing means correct.
- B. Verify it asserts the intended behavior and covers meaningful cases.
- C. Delete other tests.
- D. Raise the temperature.

<details markdown="1"><summary>Answer</summary>

**B.** Passing ≠ correct; it can lock in a bug.

</details>

**33.** Copilot most directly reduces context switching by:

- A. Training on browser history.
- B. Explaining unfamiliar code and generating examples in the editor.
- C. Blocking the internet.
- D. Disabling extensions.

<details markdown="1"><summary>Answer</summary>

**B.** Answers and examples in place keep you in flow.

</details>

**34.** Best first step to modernize a poorly understood legacy module?

- A. Rewrite it all at once with no tests.
- B. Have Copilot explain it, then modernize incrementally with tests.
- C. Delete it.
- D. Ask for a bug-free guarantee.

<details markdown="1"><summary>Answer</summary>

**B.** Understand first, change in verified steps.

</details>

**35.** Copilot suggests replacing a concatenated SQL query with a parameterized one. Treat it as:

- A. A guaranteed fix needing no checks.
- B. A helpful security suggestion to review, test, and scan.
- C. Irrelevant to security.
- D. A reason to skip review.

<details markdown="1"><summary>Answer</summary>

**B.** Good suggestion — still validated.

</details>

### Privacy, content exclusions, and safeguards

**36.** To ensure Copilot never uses files under `secrets/` as context, use:

- A. The duplication filter
- B. Content exclusions
- C. An audit log event
- D. A prompt file

<details markdown="1"><summary>Answer</summary>

**B.** Exclusions keep paths out of context (input side).

</details>

**37.** To reduce suggestions that match public code, use:

- A. Content exclusions
- B. The duplication (public-code match) filter
- C. The REST API
- D. Audit logs

<details markdown="1"><summary>Answer</summary>

**B.** The duplication filter acts on output.

</details>

**38.** To automatically add/remove Copilot seats during onboarding, use:

- A. The Copilot REST API
- B. Content exclusions
- C. The duplication filter
- D. `.github/copilot-instructions.md`

<details markdown="1"><summary>Answer</summary>

**A.** The REST API manages seats/subscriptions.

</details>

**39.** Copilot stops suggesting in one repository. A plausible *governance* cause is:

- A. Monitor refresh rate
- B. A policy disabling the feature, or a content exclusion covering those files
- C. The color theme
- D. Model temperature

<details markdown="1"><summary>Answer</summary>

**B.** Policies (availability) and exclusions (visibility) are first to check.

</details>

**40.** Which statement about accepted suggestions is correct?

- A. GitHub owns all accepted suggestions.
- B. You generally own them but remain responsible for validation and licensing.
- C. Accepting transfers all legal responsibility to GitHub.
- D. The duplication filter guarantees license compliance.

<details markdown="1"><summary>Answer</summary>

**B.** You own and stay responsible; the filter mitigates but doesn't guarantee.

</details>

---

## Further reading

> 🔗 **Source**: [Study guide for Exam GH-300: GitHub Copilot](https://learn.microsoft.com/credentials/certifications/resources/study-guides/gh-300)
