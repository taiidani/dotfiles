---
description: A sync routine for updating my local Obsidian tasks to match my assigned Jira work items.
---

# Jira Sync

I store my currently assigned Jira tickets as individual notes, conforming to the Obsidian TaskNotes community plugin. To keep this up to date, I regularly synchronize Jira with my local Obsidian notes. Instructions for accessing Jira are stored in the /jira skill.

## Determining which tickets to sync

Follow the below rules when determining the tickets to sync:

- Must be assigned to me, Ryan Nixon
- Exclude tickets in the Done status category (e.g., Done, Closed, Fixed, Dismissed)

## Where to store tickets

Tickets should be stored as notes in the `hashicorp` vault, underneath the `TaskNotes/Tasks/Jira` path. Tickets should be named according to the summary of the ticket.

- Always check to see if a note exists to be updated before creating a new note.
- Always use the Obsidian CLI to read, create and update notes. Obsidian will correctly map tickets' summary fields to a format suitable for storing in the filesystem (e.g. stripping out symbols like `:`)

## Formatting

Each TaskNotes note should be formatted with:

1. Frontmatter matching the Jira ticket's properties, with both the `task` and `jira` tags assigned.
2. A section at the top for Notes, which if populated will be flushed into a comment.
2. Content containing the ticket's description and comment history

An example of what this might look like:

```md
---
status: in-progress
priority: normal
scheduled: 2026-03-17
dateCreated: 2026-03-16T00:25:34.838-07:00
dateModified: 2026-03-20T00:26:22.794-07:00
tags:
  - task
  - jira
source: https://hashicorp.atlassian.net/browse/FORGE-64
---

# Notes

<Notes about the Jira ticket that need to be flushed into a comment. If empty, do nothing.>

# Description

<The ticket description, commonly containing subheadings like "Background", "Summary", and "Acceptance Criteria".>

# Comments

<A history of the comments on the ticket, sorted in descending date order.>
```

### Properties

The properties available to the frontmatter are:

- *status*: (Required) Maps to the Jira work item status. Available values are:
  - "open" - Matches Jira's "To Do" statuses.
  - "in-progress" - Matches Jira's "In Progress", "Blocked", "In Review", "In Discovery" and "In Development" statuses.
  - "done" - Matches Jira's "Closed" or "Done" statuses.
  - "none" - Any other Jira status should resolve to this.
- *priority*: (Optional) Maps to Jira's priority field.
  - "high" - Matches Jira's "Highest" and "High" priorities
  - "medium" - Matches Jira's "Medium" priority
  - "low" - Matches Jira's "Lowest" and "Low" priorities
- *scheduled*: YYYY-MM-DD format of the date that the Obsidian note is created. Do not update this if it is already populated.
- *dateCreated*: Maps to Jira's "Created" field.
- *dateModified*: Maps to Jira's "Updated" field.
- *tags*: Should always be set to `task` and `jira`. If the Jira ticket has its Components field set, add a tag for each assigned Component.
- *source*: The URL for the Jira ticket.

---

### Comments

The "Comments" section should contain a history of the comments on the ticket, sorted in descending date order.

- Comment author's names should be formatted as Obsidian internal links (e.g. `[[Ryan Nixon]]`)

## Updating Existing Tickets

The *only* time that an existing ticket should ever be updated is if the "Notes" section of the note has been populated. Otherwise all operations against Jira must be read-only. If an Obsidian note's "Description" or "Comments" sections are out of sync with Jira, always replace the Obsidian note's content with Jira's content.

If the "Notes" section of the note has been populated:

1. Read the content of the "Notes" section.
2. Create a new comment on the associated Jira ticket containing the contents of the "Notes" section.
3. Remove the now-processed content from the "Notes" section to ensure that the content is not processed a second time.

## Optimizations

- Short-circuit unchanged tickets early
  - Read each note’s `dateModified` frontmatter first; if it matches Jira updated and `# Notes` is empty, skip the note entirely.
- Filesystem operations may be used for *reading* Obsidian notes in bulk. However, write operations should still use the Obsidian CLI.
