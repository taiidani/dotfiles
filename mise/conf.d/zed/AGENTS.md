## Conventions

### Version Control

- Default version control is `jj` (Jujutsu). Fall back to `git` if the repo does not have a `.jj` directory.
- Never run `jj describe`, `jj new`, `jj commit`, `jj git push` or `git commit`/`git push` without asking.

### Tooling

- Use Mise for tool versions and tasks. Prefer `mise run <task>` over ad hoc commands.
- Ask before installing any new tool. If approved, add it to mise.toml rather than installing globally.
- `zsh` is the preferred shell, but `sh` is also acceptable. Use other shells only if necessary.

### Communication

- If I ask you to generate code, avoid making assumptions about the context.
- Ask clarifying questions when requirements are ambiguous. Otherwise proceed.

## Style

- Markdown prose is written using Semantic Line Breaks (https://sembr.org/), with one sentence per line. This makes it easier to read diffs and track changes.
- Prefer Mermaid for diagrams, and prefer using diagrams to illustrate complex ideas.
- Prefer minimal comments in code. If a comment is needed, it should explain the "why" rather than the "what". The "what" should be clear from the code itself.
