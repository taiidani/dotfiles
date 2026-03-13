---
name: obsidian
description: Work with Obsidian vaults using the Obsidian CLI. Use this skill when users ask to manage notes, daily notes, tasks, search, metadata, or vault settings.
---

Use this skill when the user asks to interact with Obsidian content or tooling.

## Operating Principles

1. Prefer Obsidian CLI commands over direct filesystem edits when possible.
2. Prefer native daily-note commands (`daily*`) instead of filename/date assumptions.
3. Use `vault=<name>` whenever the target vault is unclear or multiple vaults exist.
4. If unsure about command syntax, check live help first with `obsidian help` or `obsidian help <command>`.
5. For machine-readable output, add `format=json` when supported.

## Quick Discovery

```bash
# Show available vaults
obsidian vaults

# Show current vault info
obsidian vault

# Show all available commands
obsidian help

# Show help for one command
obsidian help tasks
```

## High-Value Workflows

### Daily Notes (native)

Use these first for anything related to daily notes.

```bash
# Open today's daily note
obsidian daily

# Read today's daily note
obsidian daily:read

# Get today's daily note path
obsidian daily:path

# Append/prepend content
obsidian daily:append content="\n## Priorities\n- [ ] Top priority"
obsidian daily:prepend content="# Morning Plan\n\n"
```

Common options:
- `open` - Open note after writing
- `inline` - Do not insert extra newline
- `paneType=tab|split|window` - Control where note opens

### Notes and Files

```bash
# Create/read/open
obsidian create name="Project Notes" template="Project Template" open
obsidian read file="Project Notes"
obsidian open file="Project Notes" newtab

# Rename/move/delete
obsidian rename file="Old Name" name="New Name"
obsidian move file="Project Notes" to="Archive/"
obsidian delete file="Scratch"    # add 'permanent' to skip trash

# Append/prepend content
obsidian append file="Project Notes" content="\n## Update\nDone"
obsidian prepend file="Project Notes" content="# Title\n\n"
```

### Task Management

```bash
# List tasks
obsidian tasks todo verbose
obsidian tasks done format=json
obsidian tasks daily todo

# Update tasks
obsidian task ref="Tasks.md:15" done
obsidian task file="Tasks" line=8 toggle
obsidian task daily line=5 status=">"
```

### Search and Knowledge Graph

```bash
# Text search
obsidian search query="incident review" limit=20
obsidian search:context query="TODO" format=json

# Links and graph hygiene
obsidian backlinks file="Index"
obsidian unresolved counts verbose
obsidian orphans total
obsidian deadends total
```

### Metadata and Organization

```bash
# Properties
obsidian properties counts sort=count
obsidian property:read name="status" file="Project Notes"
obsidian property:set name="status" value="in-progress" file="Project Notes"

# Tags and aliases
obsidian tags counts sort=count
obsidian tag name="project" verbose
obsidian aliases verbose
```

### Templates, Bookmarks, and Structure

```bash
# Templates
obsidian templates
obsidian template:read name="Meeting Template"
obsidian template:insert name="Meeting Template"

# Bookmarks
obsidian bookmarks verbose
obsidian bookmark file="Project Notes.md"

# Outline and counts
obsidian outline file="Project Notes" format=tree
obsidian wordcount file="Project Notes" words
```

## UI, Plugins, and System Operations

Use these when the user asks about app configuration or diagnostics.

```bash
# Plugins/themes/snippets
obsidian plugins:enabled
obsidian plugin:install id="obsidian-git" enable
obsidian theme:set name="Minimal"
obsidian snippets:enabled

# System and sync
obsidian sync:status
obsidian version
obsidian reload
obsidian restart

# Web viewer
obsidian web url="https://help.obsidian.md/cli" newtab
```

Developer/advanced:

```bash
obsidian dev:errors
obsidian dev:console limit=100 level=error
obsidian dev:screenshot path="debug/screen.png"
obsidian devtools
obsidian eval code="1+1"
```

## Usage Guidance

### Choose file selectors correctly
- Use `file=<name>` when referencing notes by title (wikilink-style resolution).
- Use `path=<path>` when exact location is required.

### Handle vault context explicitly
- If the user names a vault, include `vault=<name>` on commands.
- If unspecified and ambiguity exists, check `obsidian vaults`.

### Prefer concise, reversible operations
- Read/list before mutating when risk is high.
- Avoid destructive deletion unless requested (`permanent`).

### Format output to match task
- Use default human-readable formats for conversational responses.
- Use `format=json` for parsing, filtering, or scripting.

## Common Pitfalls

- Daily note requests should use `daily*` commands, not direct date filename assumptions.
- Many commands default to active file when `file`/`path` is omitted; be explicit when precision matters.
- Quote values with spaces: `name="My Note"`.
- Escape newlines/tabs in content values: `\n`, `\t`.

## Minimal Checklist For Obsidian Requests

1. Confirm target vault (or set `vault=<name>`).
2. Pick native command for task (`daily`, `tasks`, `search`, etc.).
3. Execute with explicit `file` or `path` when accuracy matters.
4. Return concise results and next useful action.
