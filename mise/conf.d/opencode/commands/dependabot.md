---
description: Reviews and merges open Dependabot pull requests for the taiidani organization
agent: plan
---

# Dependabot

Review and merge Dependabot PRs for the `taiidani` organization. Follow this process:

## Discover open Dependabot PRs

Use the /gh-cli skill to find all open PRs in the repos with Dependabot as the author. This command will provide the necessary information:

```sh
gh search prs org:taiidani is:open author:app/dependabot --limit 200
```

Collect the full list, noting each PR's repository, number, title, and URL.

For each found repository *spin up a Build subagent* for processing each repository. These subagents will independently evaluate the Dependabot PRs in the repository, determine if they are mergeable, and merge them or report on if they cannot. Once complete, the subagents should provide a summary of their actions.

Once all subagents have completed, summarize what was done:
- ✅ List each PR that was successfully approved and merged (repo, PR number, title)
- ⏳ List any PRs skipped because of a major semantic version bump or where checks were still pending/in-progress
- ❌ List any PRs that could not be merged due to failing checks, conflicts, or other errors — include a brief reason for each

## Subagent Instructions

### Step 1: Check CI status for each PR

For each Dependabot PR in the repository, get the CI check status (e.g. `gh pr checks`) and retrieve the combined commit status and check runs. A PR is safe to merge when:

- All required status checks are **successful** (state: `success`) or **neutral** (state: `neutral` / conclusion: `skipped`)
- No checks are in a **failure**, **error**, or **action_required** state
- No checks are still **pending** or **in_progress** — wait or skip those PRs and note them for the user

### Step 2: Check semantic version for each change

Review the changes that Dependabot is proposing in each PR. If the PR includes a change that would result in a major version bump (e.g., changing from `1.2.3` to `2.0.0`), skip that PR and report it to the user for manual review. Only automatically approve and merge PRs that propose minor or patch version bumps (e.g., `1.2.3` to `1.3.0` or `1.2.4`).

### Step 3: Approve and merge passing PRs

For each PR where all checks have passed:

1. **Approve** the PR
2. **Merge** the PR. Prefer the `squash` merge method unless the repository's settings require otherwise.

## Important notes

- **Never merge a PR with failing checks.** If any required check has failed, skip that PR and report it to the user with the failure details.
- If a merge fails due to a merge conflict or branch protection rule, report it and move on — do not attempt to resolve conflicts automatically.
- PRs may span many different repositories in the taiidani org; process them all unless the user specifies a subset.
- Dependabot PRs are typically grouped (e.g., all Go module bumps in one PR). Treat each PR as a unit — do not merge individual dependency bumps separately.
