---
name: dependabot-merger
description: Reviews and merges open Dependabot pull requests for the taiidani organization. Use this when asked to review, merge, or process Dependabot PRs.
---

When asked to review and merge Dependabot PRs for the taiidani organization, follow this process:

## Step 1: Discover open Dependabot PRs

Use the `search_pull_requests` GitHub MCP tool to find all open Dependabot PRs across the org:

```
query: "author:app/dependabot is:open org:taiidani"
```

Collect the full list, noting each PR's repository, number, title, and URL.

## Step 2: Check CI status for each PR

For each PR, use the `get_pull_request_status` tool (method: `get_status` may work, but most repositories will use GitHub Actions Check Runs instead) to retrieve the combined commit status and check runs. A PR is safe to merge when:

- All required status checks are **successful** (state: `success`) or **neutral** (state: `neutral` / conclusion: `skipped`)
- No checks are in a **failure**, **error**, or **action_required** state
- No checks are still **pending** or **in_progress** — wait or skip those PRs and note them for the user

## Step 3: Check semantic version for each change

Review the changes that Dependabot is proposing in each PR. If the PR includes a change that would result in a major version bump (e.g., changing from `1.2.3` to `2.0.0`), skip that PR and report it to the user for manual review. Only automatically approve and merge PRs that propose minor or patch version bumps (e.g., `1.2.3` to `1.3.0` or `1.2.4`).

## Step 4: Approve and merge passing PRs

For each PR where all checks have passed:

1. **Approve** the PR using the `create_pull_request_review` tool with `event: "APPROVE"` and a body such as: `"LGTM — all CI checks pass"`
2. **Merge** the PR using the `merge_pull_request` tool. Prefer the `squash` merge method unless the repository's settings require otherwise.

## Step 5: Report results

Summarize what was done:
- ✅ List each PR that was successfully approved and merged (repo, PR number, title)
- ⏳ List any PRs skipped because of a major semantic version bump or where checks were still pending/in-progress
- ❌ List any PRs that could not be merged due to failing checks, conflicts, or other errors — include a brief reason for each

## Important notes

- **Never merge a PR with failing checks.** If any required check has failed, skip that PR and report it to the user with the failure details.
- If a merge fails due to a merge conflict or branch protection rule, report it and move on — do not attempt to resolve conflicts automatically.
- PRs may span many different repositories in the taiidani org; process them all unless the user specifies a subset.
- Dependabot PRs are typically grouped (e.g., all Go module bumps in one PR). Treat each PR as a unit — do not merge individual dependency bumps separately.
