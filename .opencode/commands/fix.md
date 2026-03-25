---
description: Fix issues described in a provided external URL
agent: build
---

Build a GitHub Pull Request to address a described bug or change request described at the $1 URL.

- If this URL is at the `hashicorp.atlassian.net` domain, use the /jira skill to retrieve its information.
- If this URL is at the `github.com` domain, use the /gh-cli skill to retrieve its information.

Build, test and create a PR that addresses the given work item.
Work with the @review and @security-auditor agents to ensure the change is of high quality.
