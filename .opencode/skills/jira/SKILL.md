---
name: jira
description: Instructions for accessing Jira via API calls in the terminal. This includes fetching and creating tickets, as well as best practices for handling credentials and security. This can be invoked to learn more about a ticket when I paste its URL or its ID (example FORGE-123) into a conversation or when I start a thread with "Please create a Jira ticket".
---

# Jira API Access

When accessing Jira, use the Atlassian CLI (`acli`). If `acli` is not available, fail immediately noting that it is required.

## Common Commands

- **View a ticket:** `acli jira workitem view KEY-123`
- **Search tickets:** `acli jira workitem search --jql "project = FORGE AND assignee = currentUser()"`
- **Create a ticket:** `acli jira workitem create --project FORGE --type Task --summary "..." --description "..." --assignee 60870b7ff9def1006a84face`
- **Edit a ticket:** `acli jira workitem edit KEY-123 --summary "..." --description "..."`
- **Transition a ticket:** `acli jira workitem transition KEY-123`

Use `acli jira workitem --help` or append `--help` to any subcommand for additional options.

## Creating a Ticket

Unless specifically told otherwise, all new tickets should be created in the FORGE Jira project using the "Needs More Info" status and assigned to me.

Tickets should be of the "Task" ticket type by default.
Other common types are "Bug" and "Epic" but should not be used unless specifically asked to.

Before proceeding to create any ticket, display its description for me to review it.

When I say to "assign the ticket to me", this means the Ryan Nixon user in Jira. That user's user ID is `60870b7ff9def1006a84face`.

## Ticket Formats

Each ticket should follow the defined heading structures below and use the existing content beneath the headings as guiding statements to be replaced with actual content.
Do not modify the existing headings. Subheadings may be added beneath the existing headings to further clarify the content if needed.

The "Summary" (title of the ticket) field should be prefixed with a short identifier representing the Product that the ticket falls under, followed by a colon.
This identifier will roughly correspond to the current components available in the Forge Jira project. Some examples of good ticket titles:

- "Coder: Address orphaned infrastructure"
- "PRDE: Allow self-service destruction"
- "tfcdev: Add new 'env' subcommand"

The content of a ticket should encourage the use of hyperlinks. Hyperlinks add context and quick references to where work needs to be performed. For example, if the ticket says something like "Update the documentation in the Coder repository" it should provide a hyperlink to the docs in the hashicorp/coder repository; in this case the URL would be https://github.com/hashicorp/coder/tree/main/docs.

### Ticket Type - Task

```
## Background

Why is this Task important?

Is this Task part of a larger sequence of changes?

What current state in behavior or functionality is this proposing to change?

## Summary

What are the main goals of this Task?

What are the major changes that will need to take place to fulfill this Task?

What behavior or functionality is being changed?

## Acceptance Criteria

* What will the behavior or functionality look like upon completion?
* What specific, measurable goals do we want to achieve?
* How will success be measured?
```

### Ticket Type - Bug

```md
## Background

Did any known changes introduce this bug?

Was this bug reported as part of a conversation or external discussion?

## Summary

What is the bug? Describe clearly and concisely.

### Expected Behavior

What was supposed to happen?

### Actual Behavior

What happened instead?

Is there additional context to help understand the behavior?

## Reproduction Steps

1. What steps can the assignee take to reproduce the behavior?
```

### Ticket Type - Epic

```md
## Background

Why is this Epic important?

What problem or opportunity does it address?

How does it build on previous work or initiatives?

## Summary

What are the main goals of this Epic?

What key outcomes are expected?

What are the major activities or deliverables?

## Stakeholders

* Who are the key stakeholders involved?
* What roles do these stakeholders play?

## Target Goals

* What specific, measurable goals do we want to achieve?
* How will success be measured?
* What are the timeframes for achieving these goals?
```

### Ticket Type - Idea

```md
## What

Describe what you are proposing.

## Why

Explain why this is important for an upcoming quarter.
```

## Security Notes

- Authentication is managed by `acli auth` — never hardcode credentials in commands or files
- Always prompt the user before performing any operation that would change Jira's state.
