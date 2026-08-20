# Copilot to Agents

**The complete, exam-focused study guide for GitHub's AI developer certifications — [GH-300 (GitHub Copilot)](https://learn.microsoft.com/credentials/certifications/resources/study-guides/gh-300) and [GH-600 (Developing in Agentic AI Systems)](https://learn.microsoft.com/credentials/certifications/resources/study-guides/gh-600).**

Hands-on, grounded in official Microsoft Learn and GitHub documentation, and built for both understanding and exam readiness. Read it on the web, or download the EPUB/PDF.

[![Build & deploy](https://github.com/sebbrochet/ghcertifications/actions/workflows/build-and-deploy.yml/badge.svg)](https://github.com/sebbrochet/ghcertifications/actions/workflows/build-and-deploy.yml)

- 🌐 **Read online:** https://ghcertifications.sebbrochet.com/
- 📥 **Download (PDF & EPUB):** https://ghcertifications.sebbrochet.com/downloads/

---

## What's inside

Two AI-focused GitHub certifications, one coherent journey: shared foundations, then a dedicated track per exam, then exam readiness.

- **Part I — AI foundations for developers** (shared): generative AI, how GitHub Copilot works, prompt engineering, responsible AI.
- **Part II — GH-300 track:** Copilot in the IDE and CLI; agent mode, Copilot Edits, MCP, code review; developer productivity; administration and safeguards.
- **Part III — GH-600 track:** agent architecture & SDLC, tools & MCP, memory/state, evaluation & tuning, multi-agent orchestration, guardrails.
- **Part IV — Exam readiness:** objective checklists, high-yield facts, and a full **mock exam per certification** (40 questions each, with explained answers).
- **Annexes:** glossary, product & feature reference, objective-to-chapter map, further resources.

Every chapter follows a consistent anatomy (in 30 seconds → exam map → key concepts → how it works → real-world → exam tips → pitfalls → practice questions → further reading), with callouts, diagrams, and hands-on command/config snippets.

## Repository layout

```text
chapters/      Book content (Markdown) — the single source of truth
build/         Pandoc export chain (EPUB/PDF), cover generator, Mermaid/LaTeX config
assets/        Generated cover image
.github/       CI: build EPUB/PDF + deploy the site to GitHub Pages
mkdocs.yml     MkDocs Material configuration (web edition)
```

## Read or build locally

**Web preview (MkDocs Material):**

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m mkdocs serve
```

Then open <http://127.0.0.1:8000>.

**EPUB/PDF (Pandoc):** produced automatically by CI (see below). To build locally on a machine where Pandoc, `mermaid-cli`, and a LaTeX engine (XeLaTeX) are installed:

```powershell
.\build\make-cover.ps1        # generate assets/cover.png (Windows/GDI+)
.\build\build-pandoc.ps1      # EPUB (+ PDF if xelatex is available) -> output/
```

## How it's published

A single GitHub Actions workflow ([`.github/workflows/build-and-deploy.yml`](.github/workflows/build-and-deploy.yml)) runs on every push to `main`:

1. **validate-site** — strict `mkdocs build`.
2. **build-ebook** — Pandoc/XeLaTeX/mermaid produce the EPUB and PDF.
3. **deploy** — the freshly built files are dropped into the site and published, with the web edition, to the `gh-pages` branch.

The published site always links to the **latest** EPUB/PDF. No files are committed to `main`; there are no per-version releases.

> **GitHub setup:** Settings → Pages → Build and deployment → Source = *Deploy from a branch*, Branch = `gh-pages` / root.

## Disclaimer

This is an **independent** study guide. It is **not** affiliated with, endorsed by, or sponsored by GitHub, Inc. or Microsoft Corporation. Product names and logos are trademarks of their respective owners. Certification objectives evolve — GH-300 targets the skills measured **as of August 7, 2026**; always confirm against the official study guides before you sit an exam. See [the full disclaimer](chapters/00-disclaimer.md).

## License

This work is licensed under the **[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International](LICENSE)** license (CC BY-NC-SA 4.0). You may share and adapt it with attribution, for non-commercial purposes, under the same license. See [LICENSE](LICENSE) for details.

## Author

By **Sébastien Brochet**.
