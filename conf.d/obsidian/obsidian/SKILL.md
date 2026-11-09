---
name: obsidian
description: Persistent Obsidian-based memory for coding agents. Use at session start to orient from a knowledge vault, during work to look up architecture/component/pattern notes, and when discoveries are made to write them back. Activate when the user mentions obsidian memory, obsidian vault, obsidian notes, obsidian daily notes, or /obs commands.
---

# Obsidian

You have access to a persistent Obsidian knowledge vault — a graph-structured memory that persists across sessions. Use it to orient yourself, look up architecture and component knowledge, and write back discoveries.

This skill provides information about the user's personal preferences when working in Obsidian. Use this skill when the user asks to interact with Obsidian content or tooling.

Before performing any actions with Obsidian, confirm that the https://github.com/kepano/obsidian-skills Skills repository has been installed on the machine. You can confirm this by loading the `/obsidian-cli` skill. If the skill does not exist, halt the operation immediately and ask me to install it.

## Operating Principles

1. Prefer Obsidian CLI commands over direct filesystem edits when possible.
2. Prefer native daily-note commands (`daily*`) instead of filename/date assumptions.
3. Use `vault=<name>` whenever the target vault is unclear or multiple vaults exist.
4. If unsure about command syntax, check live help first with `obsidian help` or `obsidian help <command>`.
5. For machine-readable output, add `format=json` when supported.

## Vault Guidance

Each vault has specific content in it that needs to be matched to the task being performed.

### hashicorp (Vault)

Purpose: This is my work vault and is where most of my Obsidian work happens. For clarity, HashiCorp is a company I worked at that was acquired by IBM June, 2026, and while I still refer to my workplace as HashiCorp the names of the two companies are roughly equivalent.

Location: "~/hashicorp/obsidian/hashicorp"

Some information about this vault:

- The `archive/` folder contains historical information that was once useful to me but is no longer relevant. Old project work, notes that became stale, etc. When interacting in the vault this folder should be deprioritized as its information is very likely to be out of date or incorrect.
- The `daily/` folder contains all of my daily tracking notes. I use Obsidian's core Daily Note plugin for building out the notes. Its template is stored at `templates/daily`. When interacting with this, _always_ prefer using `obsidian daily` CLI commands over direct filesystem access.
- The `interviews/` folder contains information about how I interview employees at HashiCorp (IBM) as well as recent interview notes that I'm still recording feedback into for submission into IBM's hiring portal.
- The `people/` folder contains information about the folk that I regularly interact with at work. It holds snippets of important conversations, reminders of discussion topics (such as 1:1 notes), and general information about the person such as the team they're on.
- The `teams/` folder contains information about the teams that I regularly interact with at work. It holds information like the points of contact for the team, summaries of and links to their mission, and information about projects that I'm collaborating (or have collaborated) with them on.

### merrett and ryan (Vault)

This is a personal vault for sharing information, tasks, and research with my partner.

### taiidani (Vault)

This is a personal vault for general note taking, tracking of personal projects, and storing of articles for later reading.

## Session Start — Orientation

At the start of every session, orient yourself with **at most 2 operations**:

### Step 1: Read TODOs

**CLI-first**:

```bash
obsidian vault=$VAULT_NAME tasks path="todos" todo verbose
```

**Fallback**: Read the file at `$VAULT/todos/Active TODOs.md`.

Know what's pending, in-progress, and recently completed.

### Step 2: Detect current project and read its overview

Auto-detect the project from the current working directory:

```bash
basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null || basename $(pwd)
```

Then check if a matching project exists by listing files in `$VAULT/projects/*/`. Match the git repo name (or directory name) against project folder names. If a match is found, read the project overview at `$VAULT/projects/{matched-name}/{matched-name}.md`.

This project overview contains wikilinks to all components, patterns, architecture decisions, and domains. **Do not read those linked notes yet** — follow them on demand when the current task requires that context.

### What NOT to read at session start

- `Home.md` (only if you're lost and can't find the project)
- `sessions/` (only if the user references prior work)
- Domain indexes (only if you need cross-project knowledge)
- Component notes (only when working on that component)

## Automatic Behaviors

These behaviors apply to any agent using this skill. They do not require explicit commands.

### On session start

Auto-orient (TODOs + project overview) without being asked, following the Session Start procedure above. If the vault doesn't exist at the resolved path, inform the user and suggest running `init`.

### On session end signals

When the user says "done", "wrapping up", "that's it", "let's stop", or similar end-of-session language — offer to write a session summary. Don't auto-run; ask first: "Want me to write a session summary to the vault before we wrap up?"

### On component discovery

When you deeply analyze a component that has no vault note — and the project has an active vault — offer to create a component note and infer relationships from imports and dependencies. Example: "I noticed there's no vault note for the AuthMiddleware component. Want me to create one and map its dependencies?"

### On first run

When the vault doesn't exist at any resolved path, guide the user through `init`, then auto-scaffold the current project if inside a git repo.

## During Work — Graph Navigation

**Principle: Use CLI queries first, file reads second.** The Obsidian CLI provides structured access to properties, links, backlinks, tags, and search — prefer these over reading entire files.

### CLI-first lookups (preferred)

Use these CLI commands for targeted queries without consuming file-read tokens:

```bash
# Query a component's dependencies
obsidian vault=$VAULT_NAME property:read file="Component Name" name="depends-on"

# Find what depends on a component
obsidian vault=$VAULT_NAME property:read file="Component Name" name="depended-on-by"
obsidian vault=$VAULT_NAME backlinks file="Component Name"

# Find all outgoing links from a note
obsidian vault=$VAULT_NAME links file="Component Name"

# Find all notes of a type
obsidian vault=$VAULT_NAME tag verbose name="component"

# Search vault content
obsidian vault=$VAULT_NAME search format=json query="search term" matches limit=10

# Get note structure without full read
obsidian vault=$VAULT_NAME outline file="Component Name"

# Read a specific property
obsidian vault=$VAULT_NAME property:read file="Component Name" name="key-files"
```

Where `$VAULT_NAME` is the vault folder name (basename of `$VAULT`).

### File-read fallback (when CLI unavailable)

Fall back to file reads when the Obsidian CLI is not available:

- Need to understand a component? The project overview links to it. Read that one note.
- Need an architecture decision? The component note or project overview links to it. Follow the link.
- Need cross-project knowledge? Component/pattern notes link to domain notes. Follow the link.
- Need session history? Only read if you're stuck or the user references prior work.

### Frontmatter-first scanning

When you need to scan multiple notes to find the right one, read just the first ~10 lines of each file. The `tags`, `project`, `type`, and `status` fields in the frontmatter tell you if the note is relevant before reading the full body.

### Directory listing before reading

List directory contents before reading files — know what exists without consuming tokens:

- `$VAULT/projects/{name}/**/*.md` — all notes for a project
- `$VAULT/domains/{tech}/*.md` — domain knowledge files

## Writing to the Vault

Write concisely. Notes are for both your future context and for human consumption. Prefer:

- Bullet points over prose
- Wikilinks over repeated explanations (link to it, don't re-state it)
- Frontmatter tags for discoverability over verbose descriptions

### When to write

- **New component discovered**: Create a component note when you deeply understand a part of the codebase
- **Architecture decision made**: Record ADRs when significant design choices are made
- **Pattern identified**: Document recurring patterns that future sessions should follow
- **Domain knowledge learned**: Write to domain notes when you discover cross-project knowledge

### Scoping rules

| Knowledge type           | Location                | Example                      |
| ------------------------ | ----------------------- | ---------------------------- |
| One project only         | `projects/{name}/`      | How this API handles auth    |
| Shared across projects   | `domains/{tech}/`       | How Go interfaces work       |
| Universal, tech-agnostic | `patterns/`             | SOLID principles             |
| Session summaries        | `sessions/`             | What was done and discovered |
| TODOs                    | `todos/Active TODOs.md` | Grouped by project           |

### Frontmatter conventions

Always include in new notes:

```yaml
---
tags: [category, project/short-name]
type: <component|adr|session|project>
project: "[[projects/{name}/{name}]]"
created: YYYY-MM-DD
---
```

### Wikilink conventions

- Link to related notes: `[[projects/{name}/components/Component Name|Component Name]]`
- Link to domains: `[[domains/{tech}/{Tech Name}|Tech Name]]`
- Link back to project: `[[projects/{name}/{name}|project-name]]`

### Note templates

**Component Note:**

```yaml
---
tags: [components, project/{short-name}]
type: component
project: "[[projects/{name}/{name}]]"
created: {date}
status: active
layer: ""
depends-on: []
depended-on-by: []
key-files: []
---
```

Sections: Purpose, Gotchas

**Architecture Decision:**

```yaml
---
tags: [architecture, decision, project/{short-name}]
type: adr
project: "[[projects/{name}/{name}]]"
status: proposed | accepted | superseded
created: {date}
---
```

Sections: Context, Decision, Alternatives Considered, Consequences

**Session Note:**

```yaml
---
tags: [sessions]
type: session
projects:
  - "[[projects/{name}/{name}]]"
created: { date }
branch: { branch-name }
---
```

Sections: Context, Work Done, Discoveries, Decisions, Next Steps

## Token Budget Rules

1. **CLI over reads**: Use `obsidian` CLI for property reads, backlinks, links, tags, and search — these return targeted data without full file reads
2. **Session start**: At most 2 operations (TODOs + project overview)
3. **During work**: Use `lookup` subcommands and `relate show` before reading full notes
4. **Frontmatter first**: When scanning, read ~10 lines before committing to full read
5. **List before read**: List directory contents before reading files
6. **Write concisely**: Bullet points, links, tags — no prose when bullets suffice

## Error Handling

- If the vault doesn't exist → fail immediately and require user action
- If the project doesn't exist in the vault → offer to scaffold it
- If a note already exists → show it instead of overwriting, offer to edit
- If no git repo is detected → use current directory name as project name
- If CLI command fails → fall back to file read for the same data

## Vault Structure Reference

```
$VAULT/
├── Home.md                           # Dashboard (read only if lost)
├── projects/{name}/
│   ├── {name}.md                     # Project overview — START HERE
│   ├── architecture/                 # ADRs and design decisions
│   ├── components/                   # Per-component notes
│   └── patterns/                     # Project-specific patterns
├── domains/{tech}/                   # Cross-project knowledge
├── patterns/                         # Universal patterns
├── sessions/                         # Session logs (read only when needed)
├── todos/Active TODOs.md             # Pending work (read at session start)
├── templates/                        # Note templates
└── inbox/                            # Unsorted
```
