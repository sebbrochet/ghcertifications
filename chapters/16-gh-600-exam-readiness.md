<!-- markdownlint-disable MD041 -->
# Chapter 16 — GH-600 Exam Readiness

*Part IV — Exam readiness*

---

## In 30 seconds

- **The core idea**: a final, objective-by-objective sweep of GH-600 with a full-length practice exam.
- **Why it matters**: agentic topics are new and nuanced; a mock exam calibrates your judgment.
- **The exam angle**: a passing score is **700**; the role centers on operating and governing agents in the
  SDLC.
- **Remember**: agents are a fast-moving area — verify Preview vs GA before booking.

---

## 1. Objective checklist

- [ ] **Agent architecture & SDLC processes (15–20%)** — steps; anti-patterns; inputs/outputs/success
      criteria; planning vs execution; structured plans and validation; observability, autonomy, artifacts,
      human intervention.
- [ ] **Tool use & environment interaction (20–25%)** — tools and permissions; MCP servers, registries,
      allow lists, remote GitHub MCP; execution context; repo/branch scoping; CI invocation; autonomous
      PRs; error handling, retries, rollbacks, escalation, traceability.
- [ ] **Memory, state, and execution (10–15%)** — memory types and scoping; expiry/pruning/reset; durable
      state; resume without divergence; drift; continuity across tools.
- [ ] **Evaluation, error analysis, and tuning (15–20%)** — success criteria and signals; automated
      scanning; failure analysis; root-cause classification; tuning instructions/memory/tools.
- [ ] **Multi-agent orchestration (15–20%)** — orchestration patterns; isolation; conflict resolution;
      observability; post-hoc analysis; failure recovery; agent lifecycle.
- [ ] **Guardrails and accountability (10–15%)** — risk classification; autonomy levels; HITL; blocking
      violations; least privilege; authorization for irreversible changes; velocity.

---

## 2. High-yield facts

Memorize these before test day. Each is a compact, frequently tested fact from Chapters 9–14.

- **Passing score is 700.** The role centers on operating and governing agents in the SDLC, with GitHub as
  the system of record. Agents are fast-moving — verify Preview vs GA before booking.
- **Core safe pattern:** **plan → validate → act.** Configure planning distinct from execution; output a
  **structured plan**; prevent action until approved.
- **Every agent needs** defined **inputs, outputs, and success criteria**. No success criteria = an
  anti-pattern (unevaluable, untrustworthy).
- **Anti-patterns:** acting without a plan; unbounded scope; no success criteria; no artifacts; all-or-
  nothing autonomy.
- **Inspectable artifacts** (plan, logs, diff, draft PR) provide observability and human intervention
  **without slowing delivery**.
- **Tools carry permissions;** apply **least privilege** and scope to a **repo/branch**. Largest skill area
  is tool use & environment interaction (20–25%).
- **MCP allow lists:** enterprise **`managed-settings.json`** = **strong**, GA, non-overridable (matches by
  name/URL/stdio). **Custom registry** = weaker, public preview, bypassable. The **"MCP servers in
  Copilot"** policy governs whether MCP runs at all.
- **Cloud-agent guardrails:** only **write-access** users can trigger it; pushes to a **single branch**
  (`copilot/` or the PR branch) under branch protections; **limited credentials** (simple push only);
  opens **draft PRs** it **can't** mark ready/approve/merge; **workflows require approval** to run; the
  requester **can't self-approve**; **extra approval** for **unattributed** Copilot PRs; **restricted
  internet**; **hidden characters filtered** (prompt-injection mitigation).
- **Built-in validation:** **CodeQL**, dependency review (GitHub Advisory Database), **secret scanning** —
  **no GHAS license required**.
- **Safe execution** = error handling, **retries** (bounded), **rollbacks**, **escalation**, **traceability**.
- **Memory types:** **short-term** (current context), **long-term** (persists across sessions), **external**
  (retrieved on demand). **Scope** memory; apply **expiration/pruning/reset**.
- **State:** persist progress/decisions as **durable artifacts** to **resume** without repeating or
  diverging; watch for **context drift**; across tools prevent **conflicting** and **stale** context.
- **Evaluation loop:** define criteria → collect **signals** (quantitative + qualitative; scans) → analyze
  artifacts → **classify root cause** → tune. **Diagnose before tuning.**
- **Root-cause classes:** **reasoning errors**, **tool misuse**, **context/environment issues** — each maps
  to a fix (instructions, tools, memory/context).
- **Multi-agent conflicts:** **overlapping changes**, **duplicated effort**, **contradictory outputs**.
  **Isolation** prevents most; detect + resolve the rest. Recovery = **rollback** / **human-in-the-loop**.
- **Lifecycle:** add/update/replace/**retire** agents **without disrupting active workflows** and
  **preserving auditability**.
- **Guardrails:** **match control to risk** — automate low-risk/reversible; **HITL** for high-risk/
  irreversible/compliance-sensitive; **block** policy violations. Uniform approvals are an anti-pattern.
- **Accountability:** agent commits are **signed** and **co-authored** (Copilot + requester) with **session
  logs** and **audit events**; the **human** remains responsible.

---

## 3. Mock exam (GH-600)

40 questions, weighted roughly by skill area. Answer before expanding each explanation. Target 70%+ before
sitting the real exam.

### Prepare agent architecture and SDLC processes

**1.** The safest architectural pattern for an agent that changes code is:

- A. Act first, explain later.
- B. Produce a structured plan, validate/approve it, then execute.
- C. Full autonomy, no plan, for speed.
- D. A human types every command.

<details markdown="1"><summary>Answer</summary>

**B.** Plan → validate → act gives a cheap human checkpoint.

</details>

**2.** Which trio must be defined before building an agent?

- A. Colors, fonts, layout
- B. Inputs, outputs, success criteria
- C. Temperature, model, seed
- D. Branch, commit, tag

<details markdown="1"><summary>Answer</summary>

**B.** The agent's job must be specified and measurable.

</details>

**3.** You supervise an autonomous agent without watching every action by:

- A. Disabling logging.
- B. Relying on inspectable artifacts — plans, logs, diffs, draft PRs.
- C. Trusting it completely.
- D. Running it only on Fridays.

<details markdown="1"><summary>Answer</summary>

**B.** Artifacts make work reviewable and auditable.

</details>

**4.** Which is an agent anti-pattern?

- A. Scoping to a repo and branch
- B. Emitting a plan before acting
- C. Acting immediately with unbounded scope and no success criteria
- D. Producing a draft PR for review

<details markdown="1"><summary>Answer</summary>

**C.** Immediate, unbounded, unmeasurable action.

</details>

**5.** Separating planning from execution primarily lets you:

- A. Slow the agent for no reason.
- B. Validate the plan and stop the agent before any change.
- C. Disable tools permanently.
- D. Skip success criteria.

<details markdown="1"><summary>Answer</summary>

**B.** It creates a validation checkpoint.

</details>

**6.** Human intervention without slowing delivery is achieved by:

- A. Approving every step.
- B. Intervening at high-risk/irreversible points and automating the rest, using artifacts to review.
- C. Removing all oversight.
- D. Running everything manually.

<details markdown="1"><summary>Answer</summary>

**B.** Right-size intervention; automate the safe majority.

</details>

### Implement tool use and environment interaction

**7.** For strict, non-overridable MCP enforcement, use:

- A. A custom MCP registry
- B. An allow list in enterprise `managed-settings.json`
- C. A `.gitignore` entry
- D. Content exclusions

<details markdown="1"><summary>Answer</summary>

**B.** Managed settings are GA and non-overridable; a registry is weaker/bypassable.

</details>

**8.** The principle that should guide which tools an agent gets is:

- A. Grant every tool for flexibility.
- B. Least privilege — only what the task requires.
- C. Write access to all repos.
- D. Disable all tools.

<details markdown="1"><summary>Answer</summary>

**B.** Least privilege caps blast radius.

</details>

**9.** By default, when the cloud agent opens a PR, GitHub Actions workflows:

- A. Run automatically and immediately.
- B. Do not run until a user with write access approves them.
- C. Are permanently disabled.
- D. Run only if the agent approves them.

<details markdown="1"><summary>Answer</summary>

**B.** Workflows need human approval.

</details>

**10.** A robust safe-execution design for a flaky tool call is:

- A. Ignore the error and continue.
- B. Bounded retries, rollback of partial changes, escalation to a human — all logged.
- C. Retry forever.
- D. Immediately merge whatever exists.

<details markdown="1"><summary>Answer</summary>

**B.** Retries (limited), rollback, escalation, traceability.

</details>

**11.** The cloud agent is constrained in where it can write by:

- A. Pushing to any branch anywhere.
- B. Pushing only to a single branch (`copilot/` or the PR branch), under branch protections.
- C. Force-pushing to `main`.
- D. Unrestricted Git access.

<details markdown="1"><summary>Answer</summary>

**B.** Single-branch scope + protections; simple push only.

</details>

**12.** The "MCP servers in Copilot" policy controls:

- A. The color of the UI.
- B. Whether MCP servers can run at all across Copilot clients.
- C. The model temperature.
- D. The number of seats.

<details markdown="1"><summary>Answer</summary>

**B.** It gates MCP usage entirely.

</details>

**13.** Which reduces the impact of prompt injection on an agent?

- A. Broad permissions.
- B. Least privilege and scoped execution.
- C. Disabling logs.
- D. Auto-merging PRs.

<details markdown="1"><summary>Answer</summary>

**B.** Minimal permissions limit what any injection can do.

</details>

**14.** How can an agent be invoked as part of CI safely?

- A. It runs workflows automatically with no approval.
- B. It can be invoked in a workflow, but its PR's workflows still require write-access approval.
- C. It bypasses branch protections.
- D. It merges its own PRs.

<details markdown="1"><summary>Answer</summary>

**B.** Approval gating remains in force.

</details>

### Manage memory, state, and execution

**15.** To remember a coding convention across many future sessions, use:

- A. Short-term memory
- B. Long-term memory
- C. No memory
- D. The context window alone

<details markdown="1"><summary>Answer</summary>

**B.** Long-term persists across sessions.

</details>

**16.** To resume a long task after interruption without repeating work:

- A. Start over each time.
- B. Read durable state artifacts (plan, checklist, logs).
- C. Increase temperature.
- D. Delete previous work.

<details markdown="1"><summary>Answer</summary>

**B.** Persisted state enables deterministic resume.

</details>

**17.** Context drift is:

- A. A latency metric.
- B. Gradual divergence of an agent's behavior from the original intent over a long run.
- C. A type of MCP server.
- D. A billing model.

<details markdown="1"><summary>Answer</summary>

**B.** Divergence from intent over time.

</details>

**18.** Why apply expiration/pruning to memory?

- A. To keep every fact forever.
- B. To prevent stale context and stay within the finite window.
- C. To disable long-term memory.
- D. To increase hallucinations.

<details markdown="1"><summary>Answer</summary>

**B.** Keep memory relevant and bounded.

</details>

**19.** Sharing state across two tools, you must prevent:

- A. Conflicting and stale context
- B. Fast and slow context
- C. Public and private context
- D. Signed and unsigned context

<details markdown="1"><summary>Answer</summary>

**A.** Disagreeing sources and outdated values; use a single source of truth.

</details>

**20.** "External" memory means:

- A. Memory held only in the context window.
- B. Information retrieved on demand from a store, repo, or tool.
- C. Memory that never changes.
- D. The model's training data.

<details markdown="1"><summary>Answer</summary>

**B.** Fetched on demand rather than held in context.

</details>

### Perform evaluation, error analysis, and tuning

**21.** An agent's PRs pass all tests but the bug persists. First step?

- A. Rewrite instructions at random.
- B. Analyze artifacts (logs, plan, traces) to find the root cause.
- C. Delete production code.
- D. Increase retries.

<details markdown="1"><summary>Answer</summary>

**B.** Diagnose before tuning.

</details>

**22.** An agent chose the wrong tool for a task. Root-cause class?

- A. Reasoning error
- B. Tool misuse
- C. Context/environment issue
- D. Network outage

<details markdown="1"><summary>Answer</summary>

**B.** Tool misuse → refine tool access/guidance.

</details>

**23.** Which is a *qualitative* evaluation signal?

- A. Number of tests passed
- B. Build duration
- C. Whether the approach is correct and readable
- D. Count of CodeQL findings

<details markdown="1"><summary>Answer</summary>

**C.** Judged, not measured.

</details>

**24.** The root cause is missing project context. Best tuning action?

- A. Add broad-permission tools.
- B. Fix memory/context — supply or scope the needed info.
- C. Lower the success criteria.
- D. Remove all instructions.

<details markdown="1"><summary>Answer</summary>

**B.** Context issue → fix context.

</details>

**25.** Why must evaluation align with development intent?

- A. Surface metrics can be satisfied while the real goal fails (e.g., weakening tests).
- B. Intent is irrelevant to agents.
- C. Qualitative signals are never useful.
- D. Tests should be deleted.

<details markdown="1"><summary>Answer</summary>

**A.** Prevent gaming a metric.

</details>

**26.** Which are legitimate automated sources of evaluation signals?

- A. CodeQL, dependency review, and secret scanning
- B. The color theme
- C. The commit message font
- D. The number of open tabs

<details markdown="1"><summary>Answer</summary>

**A.** Scans produce objective signals.

</details>

### Orchestrate multi-agent coordination

**27.** The primary way to run multiple agents in parallel safely is:

- A. Give them all the same branch.
- B. Isolate each with its own scope/context (e.g., separate branches).
- C. Disable logging.
- D. Run them one at a time.

<details markdown="1"><summary>Answer</summary>

**B.** Isolation prevents collisions.

</details>

**28.** Which is a multi-agent conflict type?

- A. Overlapping code changes
- B. A slow network
- C. A large context window
- D. A signed commit

<details markdown="1"><summary>Answer</summary>

**A.** Plus duplicated effort and contradictory outputs.

</details>

**29.** A stalled agent in a multi-agent workflow should be handled by:

- A. Ignoring it and merging the rest.
- B. Detecting the stall and applying rollback or human-in-the-loop.
- C. Deleting the repository.
- D. Granting more permissions.

<details markdown="1"><summary>Answer</summary>

**B.** Detect degraded state; recover.

</details>

**30.** Post-hoc analysis of a multi-agent run requires:

- A. Turning off logging.
- B. Documented decisions, handoffs, and outcomes as auditable artifacts.
- C. Relying on agent memory only.
- D. Merging without review.

<details markdown="1"><summary>Answer</summary>

**B.** Artifacts enable reconstruction.

</details>

**31.** Retiring an agent from a running workflow requires:

- A. Doing it instantly regardless of active work.
- B. Retiring without disrupting active workflows and preserving auditability.
- C. Deleting its past logs first.
- D. Distributing its permissions to all agents.

<details markdown="1"><summary>Answer</summary>

**B.** Preserve continuity and history.

</details>

**32.** An orchestrator/worker pattern is:

- A. A billing tier.
- B. A lead agent delegating sub-tasks to specialized agents.
- C. A type of branch protection.
- D. A memory store.

<details markdown="1"><summary>Answer</summary>

**B.** Coordination via delegation.

</details>

### Implement guardrails and accountability

**33.** How much autonomy to grant an action is governed by:

- A. Full autonomy for everything.
- B. Matching the control to the action's risk.
- C. Human approval for every action.
- D. The time of day.

<details markdown="1"><summary>Answer</summary>

**B.** Automate low-risk; HITL for high-risk/irreversible.

</details>

**34.** Can the cloud agent merge its own PR by default?

- A. Yes, automatically.
- B. No — it opens a draft PR a human must review and merge.
- C. Yes, if tests pass.
- D. Only on weekends.

<details markdown="1"><summary>Answer</summary>

**B.** It can't mark ready, approve, or merge.

</details>

**35.** Why does GitHub prevent the requester from approving the agent's PR (when approval is required)?

- A. To slow that developer down.
- B. To preserve separation-of-duties / required-approval controls.
- C. Approvals are disabled for agents.
- D. The agent approves instead.

<details markdown="1"><summary>Answer</summary>

**B.** Preserves required-approval controls.

</details>

**36.** Uniform human approval for every agent action is:

- A. Best practice.
- B. An anti-pattern — it kills velocity without targeting real risk.
- C. Required by GitHub.
- D. Impossible.

<details markdown="1"><summary>Answer</summary>

**B.** Approve the irreversible; automate the safe.

</details>

**37.** Accountability for an autonomous agent's work on GitHub is provided by:

- A. The agent being legally responsible.
- B. Signed, co-authored commits + session logs + audit events; humans remain accountable.
- C. No traceability at all.
- D. Only the model provider being accountable.

<details markdown="1"><summary>Answer</summary>

**B.** Traceable work; human accountability.

</details>

**38.** An extra approval is required when a Copilot PR:

- A. Passes tests.
- B. Isn't attributed to a person (unattributed).
- C. Is small.
- D. Targets a feature branch.

<details markdown="1"><summary>Answer</summary>

**B.** Unattributed Copilot PRs need an additional approval (where approvals are required).

</details>

**39.** Which action most clearly warrants human-in-the-loop?

- A. Reading an issue.
- B. Deploying to production (irreversible/high-risk).
- C. Listing open PRs.
- D. Formatting a file.

<details markdown="1"><summary>Answer</summary>

**B.** Irreversible, high-risk actions need HITL.

</details>

**40.** GitHub's coding agent validates generated code using:

- A. CodeQL, dependency review, and secret scanning — no GHAS license required.
- B. Only manual review.
- C. Nothing by default.
- D. A separate paid product only.

<details markdown="1"><summary>Answer</summary>

**A.** Built-in security validation without a GHAS license.

</details>

---

## Further reading

> 🔗 **Source**: [Study guide for Exam GH-600: Developing in Agentic AI Systems](https://learn.microsoft.com/credentials/certifications/resources/study-guides/gh-600)
