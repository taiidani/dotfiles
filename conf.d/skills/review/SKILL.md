---
name: review
description: Pre-push code review of the local commit stack. Walks Jujutsu (jj) revisions commit-by-commit — falling back to git — runs the project's lint and test tasks, and returns a numbered, severity-tiered report with clickable file:line references. Strictly read-only and never pushes.
disable-model-invocation: true
---

# Pre-Push Code Review

Use this skill when the user runs `/review`. It reviews the local commits that have not yet been
pushed, so the user can decide whether to run `jj git push` themselves.

## Non-Negotiable Rules

1. **Never push.** Do not run `jj git push`, `git push`, or any variant, under any circumstance —
   even if the user asks mid-review. Reviewing and pushing are separate actions. If asked, refuse
   and tell them to run it themselves after reading the report.
2. **Read-only.** Do not edit, create, delete, or move any file in the working copy. Do not run
   mutating VCS commands (`jj describe`, `jj new`, `jj squash`, `jj abandon`, `jj edit`,
   `jj bookmark`, `git commit`, `git checkout`, …). The only permitted side effects are the lint
   and test tasks in Step 4, which may write caches or build artifacts.
3. **Report, don't fix.** Never apply a fix, even an obvious one. The user reads the report and
   then prompts for individual fixes in a follow-up turn. Suggested fixes belong in the report as
   prose or short illustrative snippets only.
4. **The user owns the verdict.** Do not declare the stack "safe to push" or "not safe to push".
   Assign severities, summarize, and stop. The push decision is theirs.

## Step 1 — Detect VCS and Determine Scope

Run `jj root`. If it succeeds, use **jj mode**. If it fails, use **git mode**.

### jj mode

Default revset: `trunk()..@`. This works even when no bookmark exists yet, which is the common
case before a first push. If the user supplied an explicit revset (e.g. `/review -r 'abc..def'`),
use theirs instead.

List the commits oldest-first — review order matters:

```sh
jj --no-pager log -r 'trunk()..@' --no-graph --reversed \
  -T 'change_id.shortest(8) ++ "\t" ++ description.first_line() ++ "\n"'
```

If the range is empty, say there is nothing to review and stop.

### git mode

Resolve the upstream with `git --no-optional-locks rev-parse --abbrev-ref --symbolic-full-name '@{u}'`.
If there is no upstream, fall back to `origin/main`, then `origin/master`. Then list commits with
`git --no-pager log --reverse --format='%h%x09%s' <upstream>..HEAD` and read each with
`git --no-pager show <sha>`.

Everything below applies to both modes; jj commands are shown because jj is the assumed default.

## Step 2 — Pre-Flight Checks

Run these before reading any diff. Report the results, then continue the review regardless of what
they find.

| Check | Revset | Severity |
|---|---|---|
| Conflicted revisions | `trunk()..@ & conflicts()` | 🔴 Blocker |
| Crosses the immutable boundary | `trunk()..@ & immutable()` | 🔴 Blocker |
| Empty / placeholder description | `trunk()..@ & description(exact:"")` | 🟠 Warning |
| Empty commit | `trunk()..@ & empty()` | 🟠 Warning |

Note: the working copy `@` is legitimately empty and undescribed most of the time. Only warn about
`@` if it contains changes the user may not have meant to include. Also flag descriptions that are
technically non-empty but useless (`wip`, `fix`, `asdf`).

## Step 3 — Review Commit-by-Commit

Inline editor annotations are not available in Zed's agent panel, so commit-by-commit structure is
how the review stays navigable. Review each commit **in its own right**, oldest to newest.

For each commit:

```sh
jj show <change_id> --git
```

For a large commit, start with `jj diff -r <change_id> --stat` to triage, then pull individual
files with `jj diff -r <change_id> --git <path>`.

Before judging a hunk, read enough surrounding context from the file on disk to avoid
out-of-context criticism. Judge each commit on its own merits, but call it out when a later commit
in the stack fixes or reverts something an earlier one introduced — that usually means the commits
should be squashed.

### Load language skills

If the diff touches a language or tool that has a matching skill available, load it and apply its
guidance. For example, load the `go` skill for `.go` files and the `mise` skill for `mise.toml` or
task definitions. Do this once per language, not once per commit.

### Review checklist

Apply to every commit:

- **Correctness and edge cases** — off-by-ones, nil/empty handling, error paths, concurrency,
  unchecked type assertions, resource leaks.
- **Code quality** — clarity over cleverness, consistency with the surrounding codebase, dead code,
  duplicated logic, unnecessary complexity.
- **Performance** — accidental O(n²), queries in loops, unbounded allocation, missing pagination.
- **Security** — injection, unvalidated input, authz gaps, unsafe deserialization.
- **Secrets and credentials** — API keys, tokens, private keys, passwords, connection strings,
  committed `.env` files. Treat any suspected leak as 🔴 Blocker even if it looks like a
  placeholder, and say explicitly that the secret must be rotated if it was ever real.
- **Test coverage** — is it maintained or improved? Changed behavior without a changed or added
  test is a finding.
- **Debug leftovers** — `fmt.Println`, `spew.Dump`, `dbg!`, `println!`, `console.log`, `debugger`,
  `pp`/`binding.pry`, `var_dump`, plus disabled tests: `t.Skip`, `#[ignore]`, `.only(`, `fit(`,
  `xit(`.
- **Stray markers** — `TODO`, `FIXME`, `XXX`, `HACK` **introduced by this diff**. Pre-existing ones
  are out of scope.
- **Commit hygiene** — does the message describe the change accurately? Does the commit do one
  thing, or has unrelated work crept in?

Only flag debug leftovers and stray markers that appear on **added** lines in the diff. Do not
grep the whole repository.

### Large stacks

If the stack exceeds roughly 5 commits or 1000 changed lines, delegate per-commit review to
parallel sub-agents, assigning each a disjoint set of commits. Every sub-agent must be told it is
strictly read-only, must never push, and must return findings in the exact report format below.
Merge and renumber their findings yourself before presenting.

## Step 4 — Project Checks

Only if the project defines mise tasks. Discover them with:

```sh
mise tasks ls --name-only
```

Run every task whose name starts with `lint` or `test` (so `lint`, `lint:go`, `test-unit` all
qualify) via `mise run <task>`. Bound each with `timeout_ms`. Do not run any other task — build,
deploy, release, and clean tasks are off limits.

Report each as pass or fail. For failures, include the relevant error lines, and link the failure
to the commit that caused it when you can tell. A failing lint or test task is 🟠 Should-fix at
minimum, 🔴 Blocker if the change under review clearly caused it.

If there is no mise config, say so and skip this step.

## Step 5 — Report

Output the report in the chat. Number findings sequentially across the entire report so the user
can say "fix 3 and 7" in a follow-up.

Write file references as `path/to/file.go:42`, relative to the project root — Zed renders these as
clickable links.

Severity tiers:

- 🔴 **Blocker** — must not be pushed as-is.
- 🟠 **Should-fix** — a real problem worth fixing before pushing.
- 🔵 **Nit** — style, naming, polish. Safe to ignore.

Use this structure:

```markdown
## Review — 3 commits, `trunk()..@`

| # | Severity | Finding | Location |
|---|---|---|---|
| 1 | 🔴 Blocker | Hardcoded API token | `internal/api/client.go:31` |
| 2 | 🟠 Should-fix | Missing error check on `Close()` | `cmd/serve/main.go:88` |
| 3 | 🔵 Nit | Redundant comment | `internal/api/client.go:12` |

**Pre-flight:** 1 conflicted revision · descriptions OK
**Checks:** `lint` ✅ · `test` ❌ (2 failures)

---

### `mtktorto` — first commit

#### 1. 🔴 Hardcoded API token
`internal/api/client.go:31`

The token is committed in plaintext and will be in the pushed history permanently.

Suggested direction: read it from the environment at construction time. If this token is real,
rotate it — removing it from the file does not remove it from the commit.

#### 3. 🔵 Redundant comment
`internal/api/client.go:12`

The comment restates the function signature.

---

### `mmsvktlw` — second commit

_No findings._
```

Close the report with a one-line count by severity and a reminder that the push decision is theirs,
for example:

> 1 blocker, 1 should-fix, 1 nit. Reply with the finding numbers you want me to fix — I won't push.

If there are no findings at all, say so plainly instead of manufacturing nits.
