<!-- markdownlint-disable MD041 -->
# Annex B — Product & feature reference

*Annexes*

> Quick reference "cards" for the products and features tested by GH-300 and GH-600. Each notes what it is,
> when to use it, and the chapter it maps to.

---

## GitHub Copilot surfaces

- **Inline suggestions** — grey ghost-text completions as you type; accept with <kbd>Tab</kbd>. Best for
  in-flow coding. (Ch. 5)
- **Copilot Chat** — conversational help with slash commands (`/explain`, `/fix`, `/tests`) and context
  references (`#file`, `#selection`). Best for explaining/refactoring specific code. (Ch. 3, 5)
- **GitHub Copilot CLI** — standalone `copilot` terminal agent; interactive or programmatic (`-p`); plan
  mode; can edit files, run commands, open PRs; asks approval; run from trusted directories. (Ch. 5)
- **Agent mode** — autonomous, goal-driven multi-file changes that run tools (tests/build) and iterate.
  (Ch. 6)
- **Copilot Edits** — described multi-file edits you scope and accept/discard as a set. (Ch. 6)

## Customization & extensibility

- **Instructions files** — standing standards: `.github/copilot-instructions.md` (repo-wide); path-specific
  `.github/instructions/*.instructions.md` with `applyTo`; `AGENTS.md` (agent). Precedence: personal > repo
  > org. (Ch. 6)
- **Prompt files** — reusable, repeatable requests saved in the repo. (Ch. 6)
- **Model Context Protocol (MCP)** — open standard to connect agents to external tools/data; GitHub MCP
  server built in. (Ch. 6, 10)
- **Custom agents / sub-agents** — specialized agents (e.g., Explore, Task, Code review) the model can
  delegate to; defined in Markdown at user/repo/org level. (Ch. 6)
- **Spaces** — curated, reusable/shareable context. (Ch. 6)
- **Spark** — build an app from a description. (Ch. 6)

## Administration & safeguards

- **Organization policies** — enable/disable features and set availability across IDEs and github.com.
  (Ch. 8)
- **Copilot Code Review policies** — govern availability of Copilot's PR review. (Ch. 6, 8)
- **Content exclusions** — keep specified files/paths out of Copilot's context (input side). (Ch. 8)
- **Public-code duplication filter** — suppress suggestions matching public code (output side). (Ch. 8)
- **Audit log events** — records of Copilot admin/usage events; answer "who did what." (Ch. 8)
- **Copilot REST API** — manage seats/subscriptions programmatically. (Ch. 8)

## MCP governance (GH-600)

- **"MCP servers in Copilot" policy** — whether MCP servers may run at all. (Ch. 10)
- **MCP allow list — managed settings** — enterprise `managed-settings.json`; GA, strong, non-overridable
  (matches by name/URL/stdio). Preferred. (Ch. 10)
- **MCP allow list — custom registry** — self-hosted; public preview; weaker/bypassable. (Ch. 10)

## Agentic building blocks (GH-600)

- **Structured plan** — explicit steps produced before acting; enables validation. (Ch. 9)
- **Agent memory** — short-term / long-term / external; scope and apply expiry/pruning/reset. (Ch. 11)
- **Evaluation signals & scanning** — quantitative/qualitative signals; CodeQL, dependency review, secret
  scanning as sources. (Ch. 12)
- **Multi-agent orchestration** — patterns, isolation, conflict resolution, recovery, lifecycle. (Ch. 13)
- **Guardrails / autonomy levels / HITL** — match control to risk; least privilege; block violations. (Ch. 14)

## Cloud-agent guardrails at a glance (GH-600)

- Only **write-access** users trigger it; pushes to a **single branch**; **limited credentials** (simple
  push). Opens **draft PRs** it can't approve/merge; **workflows need approval**; requester can't
  self-approve; **extra approval** for unattributed PRs; **restricted internet**; **CodeQL + secret
  scanning** (no GHAS license); **signed, co-authored commits** + session logs + audit events. (Ch. 10, 14)
