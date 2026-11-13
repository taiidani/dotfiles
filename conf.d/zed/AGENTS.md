# Version Control

- Default version control is `jj` (Jujutsu). Fall back to `git` only if the repo does not have a `.jj` directory.
- Never modify (`jj describe`) or rebase (`jj rebase`) a non-empty commit unless specifically told to. Never push (`jj git push`) unless specifically told to.
- Always include `--no-pager` in `jj` commands to avoid blocking on interactive prompts.

## Coordination via Workspaces

I like to code alongside you and run my own `jj` commands while you work.
Use `jj` workspaces (`jj workspace add/list/forget`) to coordinate.
When I ask you to work on a task that involves code generation, create a new workspace for that task and switch to it.
When the task is complete, forget and delete the workspace.

The general flow of sessions will be:

1. I prompt you with a task, and you determine that the task involves code generation.
2. You create a new workspace for the task and switch to it.
3. You start a new commit in the workspace, starting from the current state of the default workspace.
3. You generate code in the workspace. 
4. I review the code and provide feedback. I may modify the code, squash commits, or rebase the workspace before asking you to continue.
5. You continue generating code in the workspace until I declare the task is complete.
6. You forget and delete the workspace.

The name of the workspace should be hyphenated and descriptive of the ask being made in the session.

When working within a session workspace, you are free to create new described commits as you work.
You must not modify or rebase existing non-empty commits created outside the session unless specifically told to.

# Tooling

- Use Mise for tool versions and tasks. Prefer `mise run <task>` over ad hoc commands.
- Ask before installing any new tool. If approved, add it to mise.toml rather than installing globally.
- `zsh` is the preferred shell, but `sh` is also acceptable. Use other shells only if necessary.

# Communication

- If I ask you to generate code, avoid making assumptions about the context.
- Ask clarifying questions when requirements are ambiguous. Otherwise proceed.

# Writing Style

- Write for expert engineers with ADHD.
- Markdown prose is written using Semantic Line Breaks (https://sembr.org/), with one sentence per line. This makes it easier to read diffs and track changes.
- Prefer Mermaid for diagrams, and prefer using diagrams to illustrate complex ideas.
- Prefer minimal comments in code. If a comment is needed, it should explain the "why" rather than the "what". The "what" should be clear from the code itself.

# Knowledge Base

`obsidian` is the primary personal knowledge tracking tool.
It is used as a memory store for things I learn about my work, my personal life, and the world in general.

I use different Obsidian vaults for storing this information, which you can determine based on the origin of the repository (`jj git remote list`) that I am working in.

- All repositories using the "hashicorp" org on GitHub are associated with the `hashicorp` vault, so commands will start with `obsidian vault=hashicorp`.
- All repositories using the "taiidani" org on GitHub are associated with the `taiidani` vault, so commands will start with `obsidian vault=taiidani`.
- Any other repository or folder without VCS attached is out of scope and should not participate in the knowledge base.

If you need to look up information about a topic and it cannot be determined from the context and repository contents, search for it in the appropriate vault.
If I give you information worth saving (see Conventions below), store it in the appropriate vault.

Each vault has a specific `agent/` folder to work in.
It contains an `AGENTS.md` file that describes the structure of the folder and how to use it.
Use this file to determine where to read and store information in the vault.

## Conventions

- Use the `obsidian-cli` skill for vault operations.
- Use the `obsidian-markdown` skill for formatting notes.
- Only read and write information in the `agent/` folder of the vault.
- Only store durable facts such as architecture, conventions and decisions, not session chatter.
- Never store secrets, tokens or credentials.
- Prefer to update existing notes rather than creating new ones, unless the information is clearly distinct.
- If a vault is unavailable, inform me and ask for instructions on how to proceed. Do not attempt to store information in a vault that is unavailable.
