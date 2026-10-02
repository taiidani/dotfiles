# Conventions

## Version Control

- Default version control is `jj` (Jujutsu). Fall back to `git` if the repo does not have a `.jj` directory.
- Never run `jj describe`, `jj new`, `jj commit`, `jj git push` or `git commit`/`git push` without asking.

## Tooling

- Use Mise for tool versions and tasks. Prefer `mise run <task>` over ad hoc commands.
- Ask before installing any new tool. If approved, add it to mise.toml rather than installing globally.
- `zsh` is the preferred shell, but `sh` is also acceptable. Use other shells only if necessary.

## Communication

- If I ask you to generate code, avoid making assumptions about the context.
- Ask clarifying questions when requirements are ambiguous. Otherwise proceed.

# Style

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
