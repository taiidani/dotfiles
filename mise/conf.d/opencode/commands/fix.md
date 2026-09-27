---
description: Fix issues described in a provided external URL
agent: build
---

# Fix Command

Build a GitHub Pull Request to address a described bug or change request described at the $1 URL.

- If this URL is at the `hashicorp.atlassian.net` domain, use the /jira skill to retrieve its information.
- If this URL is at the `github.com` domain, use the /gh-cli skill to retrieve its information.

Build, test and create a PR that addresses the given work item.

## Development Environment

You can assume that the current directory contains a git working copy of the repository where the PR should be created, and that it has instructions for building and testing the change.

Use a worktree to ensure that your change is isolated from other changes being developed in the working copy.

## Review

Work with the @review and @security-auditor agents to ensure the change is of high quality.

Ensure that the CI tests for the PR pass before considering the work done.
If you believe CI is failing for a reason other than your changes, provide recommended troubleshooting steps upon completion.
