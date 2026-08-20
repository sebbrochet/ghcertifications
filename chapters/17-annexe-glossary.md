<!-- markdownlint-disable MD041 -->
# Annex A — Glossary

*Annexes*

> Consolidated definitions from the chapters, one wording per term, alphabetized. Chapter references point
> to where the term is introduced.

---

- **Agent** — an AI system that pursues a goal by planning steps, taking actions through tools, observing
  results, and iterating with some autonomy, rather than producing a single response. (Ch. 9)
- **Agent isolation** — giving each agent its own context, scope, and workspace (e.g., separate branches) so
  parallel agents don't interfere; the precondition for safe parallelism. (Ch. 13)
- **Agent mode** — a Copilot capability where it works autonomously toward a goal: deciding which files to
  change, running tools (build, tests), and iterating until done or blocked. (Ch. 6)
- **Allow list (MCP)** — an administrator-defined list of approved MCP servers; prefer enterprise
  `managed-settings.json` for strong, non-overridable enforcement over a custom registry. (Ch. 10)
- **Autonomy level** — the degree of independent action granted to an agent for a class of actions, assigned
  by classifying actions by operational, security, and compliance risk. (Ch. 14)
- **Content drift** — see **Context drift**.
- **Content exclusion** — an admin setting that prevents specified files or repositories from being used as
  context by Copilot; they are never sent to the model (input side). (Ch. 8)
- **Context** — everything the model "sees" for a request: your words plus the code Copilot gathers (current
  file, selection, neighboring tabs) and anything you deliberately reference. (Ch. 3)
- **Context drift** — the gradual divergence of an agent's behavior from the original intent during a long
  run. (Ch. 11)
- **Context switching** — the productivity cost of leaving a task to look something up elsewhere; Copilot
  reduces it by answering and generating examples in place. (Ch. 7)
- **Context window** — the maximum number of tokens (prompt + response) a model can process in one request.
  (Ch. 1)
- **Copilot Edits** — an IDE capability where you describe a change and Copilot proposes edits across
  multiple files you scope, which you accept or discard as a set. (Ch. 6)
- **Duplication detection filter (public-code match)** — an optional setting that suppresses suggestions
  matching public code on GitHub (output side); an IP/licensing safeguard. (Ch. 8)
- **Evaluation signal** — an observable indicator of agent performance; quantitative (measurable) or
  qualitative (judged). (Ch. 12)
- **Few-shot prompting** — including one or more examples of the desired input/output or style so the model
  imitates the pattern. (Ch. 3)
- **GitHub Copilot CLI** — a command-line tool that brings a Copilot agent into your terminal to answer
  questions, write/debug code, run tasks, and interact with GitHub.com. (Ch. 5)
- **Guardrail** — a constraint that limits what an agent may do: a permission boundary, a required approval,
  a blocked action, an execution scope. (Ch. 14)
- **Hallucination (fabrication)** — a confident, plausible-sounding output that is factually wrong; inherent
  to probabilistic generation. (Ch. 1)
- **Human-in-the-loop (HITL)** — a checkpoint requiring explicit human approval before an agent proceeds;
  reserved for high-judgment or irreversible actions. (Ch. 14)
- **Inline suggestion** — grey "ghost text" Copilot proposes at your cursor as you type. (Ch. 5)
- **Inspectable artifact** — a durable, reviewable output an agent produces (plan, session log, diff, draft
  PR) that enables supervision. (Ch. 9)
- **Instructions file** — a Markdown file of standing guidance Copilot applies automatically
  (`.github/copilot-instructions.md`; path-specific `*.instructions.md`; `AGENTS.md`). (Ch. 6)
- **Large language model (LLM)** — a neural network trained to predict the next token given prior tokens;
  the engine behind Copilot. (Ch. 1)
- **Least privilege** — granting the minimum permissions and narrowest execution scope an action requires,
  to cap blast radius. (Ch. 10, 14)
- **Memory (agent)** — information an agent retains: short-term (current context), long-term (persists
  across sessions), or external (retrieved on demand). (Ch. 11)
- **Model Context Protocol (MCP)** — an open standard for connecting AI agents to external tools and data
  sources through "MCP servers." (Ch. 6, 10)
- **MCP server** — a server implementing MCP that exposes tools and data to an agent in a standard,
  discoverable way; the GitHub MCP server is built in. (Ch. 10)
- **Orchestration pattern** — the structure that coordinates multiple agents (orchestrator/worker,
  sequential, parallel) toward a shared goal. (Ch. 13)
- **Prompt (Copilot)** — the bundle of context Copilot assembles and sends to the model, more than what you
  typed. (Ch. 2)
- **Prompt engineering** — designing and refining instructions and context to get more accurate, relevant,
  useful output. (Ch. 3)
- **Prompt file** — a reusable, parameterizable prompt saved in the repository so a team runs the same
  request consistently. (Ch. 6)
- **Proxy** — a GitHub-operated service between your editor and the model where filtering and processing are
  applied. (Ch. 2)
- **Responsible AI** — building and using AI in ways that are fair, reliable & safe, private & secure,
  inclusive, transparent, and accountable. (Ch. 4)
- **Root-cause classification** — sorting a failure into reasoning error, tool misuse, or context/
  environment issue so the fix targets the real problem. (Ch. 12)
- **State (agent)** — the record of where the agent is in its task (progress, decisions, remaining work),
  persisted as durable artifacts to enable resume. (Ch. 11)
- **Structured plan** — an explicit, inspectable list of intended steps produced before acting. (Ch. 9)
- **Sub-agent** — a specialized agent a primary agent delegates a sub-task to, running in its own context to
  optimize token usage. (Ch. 6)
- **Success criteria** — the explicit, testable conditions that define a successful agent outcome. (Ch. 9, 12)
- **Token** — the unit an LLM reads and writes, roughly a word fragment; models have a finite context
  measured in tokens. (Ch. 1)
- **Tool** — a capability an agent can invoke to affect the world (read a file, run a command, open a PR),
  carrying permissions. (Ch. 10)
- **Zero-shot prompting** — asking for a result with no example, relying on the model's general training.
  (Ch. 3)
