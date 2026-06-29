# Dev environment — DOX root

This is the **top of the DOX rail** for everything under `~/Development`. It carries
high-level context about Keith's overall dev environment plus the global DOX rules. Each
project below (e.g. `piidesk/`) has its own `AGENTS.md` that owns its subtree and stays
scoped to that project; this file owns what spans projects.

`~/Development` is itself the **dotfiles git repo** (`keithnlarsen/dotfiles`, `main`): the `.git`
is rooted here, this DOX root + the `dotfiles/` project are tracked, and the sibling project
repos (`piidesk/`, `markov/`) are `.gitignore`d so they stay independent.

## Dev environment context

- **Terminal IDE.** Keith works in a hand-rolled **Alacritty + tmux + Neovim** IDE (replaced
  VS Code; lean, not a distro), launched by the `ide` command (roots at `~/Development`). Leader = Space, tmux prefix =
  `Ctrl-a`, `prefix ?` opens a cheatsheet popup. Configs live in the **`dotfiles/`** project here
  (see the Child DOX Index and `dotfiles/AGENTS.md`).
- **Editing the IDE mid-session.** When Keith asks to tweak the terminal, editor, tmux, font,
  cheatsheet, or the `ide` launcher, work in `dotfiles/...` (the source of truth) even if the
  active project is something else like piidesk. The `~/.config/*` paths and `~/.local/bin/ide`
  are symlinks into `dotfiles/`.

## DOX framework

- DOX is a highly performant AGENTS.md hierarchy.
- The agent must follow DOX instructions across any edits.

### Core Contract

- AGENTS.md files are binding work contracts for their subtrees.
- Work products, source materials, instructions, records, assets, and durable docs must stay
  understandable from the nearest applicable AGENTS.md plus every parent AGENTS.md above it.

### Read Before Editing

1. Read this DOX root (`~/Development/AGENTS.md`).
2. Identify every file or folder you expect to touch.
3. Walk from the DOX root to each target path.
4. Read every AGENTS.md found along each route.
5. If a parent AGENTS.md lists a child AGENTS.md whose scope contains the path, read that child and continue from there.
6. Use the nearest AGENTS.md as the local contract and parent docs for repo-wide rules.
7. If docs conflict, the closer doc controls local work details, but no child doc may weaken DOX.

Do not rely on memory. Re-read the applicable DOX chain in the current session before editing.

### Update After Editing

Every meaningful change requires a DOX pass before the task is done.

Update the closest owning AGENTS.md when a change affects:

- purpose, scope, ownership, or responsibilities
- durable structure, contracts, workflows, or operating rules
- required inputs, outputs, permissions, constraints, side effects, or artifacts
- user preferences about behavior, communication, process, organization, or quality
- AGENTS.md creation, deletion, move, rename, or index contents

Update parent docs when parent-level structure, ownership, workflow, or child index changes.
Update child docs when parent changes alter local rules. Remove stale or contradictory text
immediately. Small edits that do not change behavior or contracts may leave docs unchanged, but
the DOX pass still must happen.

### Hierarchy

- This file is the DOX rail: cross-project context, global preferences, durable workflow rules, and the top-level Child DOX Index.
- Child AGENTS.md files own domain-specific instructions and their own Child DOX Index.
- Each parent explains what its direct children cover and what stays owned by the parent.
- The closer a doc is to the work, the more specific and practical it must be.
- A project may keep a `CONTEXT.md` at its own repo root as its domain glossary (piidesk does). Name domain concepts there; AGENTS.md owns workflow and structure, not vocabulary.

### Child Doc Shape

- Create a child AGENTS.md when a folder becomes a durable boundary with its own purpose, rules, responsibilities, workflow, materials, or quality standards.
- Work Guidance must reflect the current standards of the project or user instructions; if there are no specific standards or instructions yet, leave it empty.
- Verification must reflect an existing check; if no verification framework exists yet, leave it empty and update it when one exists.

Default section order:
- Purpose
- Ownership
- Local Contracts
- Work Guidance
- Verification
- Child DOX Index

### Style

- Keep docs concise, current, and operational.
- Document stable contracts, not diary entries.
- Put broad rules in parent docs and concrete details in child docs.
- Prefer direct bullets with explicit names.
- Do not duplicate rules across many files unless each scope needs a local version.
- Delete stale notes instead of explaining history.
- Trim obvious statements, repeated rules, misplaced detail, and warnings for risks that no longer exist.

### Closeout

1. Re-check changed paths against the DOX chain.
2. Update nearest owning docs and any affected parents or children.
3. Refresh every affected Child DOX Index.
4. Remove stale or contradictory text.
5. Run existing verification when relevant.
6. Report any docs intentionally left unchanged and why.

## Global User Preferences

When the user requests a durable behavior change that spans projects, record it here; behavior
specific to one project goes in that project's AGENTS.md.

- **GitHub Issues**: For large tasks, create a GitHub issue with the full plan before starting.
  Once work is pushed, comment on the issue and ask the user if they wish to close it.

## Child DOX Index

| Path | Scope |
|------|-------|
| `piidesk/AGENTS.md` | **The piidesk app** (Deno/Hono + Vite React portfolio tool). Owns its full `src/`, `devops/`, `e2e/` subtree, its toolchain rules, and its own domain glossary (`CONTEXT.md`). |
| `dotfiles/AGENTS.md` | **Terminal-IDE config project** (Alacritty / tmux / nvim, the `ide` launcher, `zsh/ide.zsh`). Real files here; `install.sh` symlinks them into `~/.config/*` and `~/.local/bin/ide`. Tracked by this repo (the `.git` at `~/Development`). Public on GitHub (`keithnlarsen/dotfiles`) — secret-scan before pushing. |
| `markov/` | Separate project, its own git repo (`.gitignore`d here); no DOX doc yet. |
