---
name: daily-routine
description: A daily set of operations I perform when starting my workday, including updating my daily note with meetings and Jira tickets. I'll often invoke this by saying "Start my daily routine".
---

# Daily Routine

Every morning, I will ask to perform my daily routine. This routine involves writing status updates in my daily Obsidian note for each of my currently assigned Jira tickets and performing specific housekeeping operations on my system.

## Obsidian Daily Note

The daily note can be accessed through the /obsidian skill. If the note does not yet exist, I should be prompted to create it. If the note exists already and has a populated "Tasks" section, skip the entire rest of this "Obsidian Daily Note" section. Please perform this check before anything else as the other steps (Calendar, Jira) are expensive to perform.

The note will have a "Tasks" heading with two subsections:
- **Meetings**: One line per meeting I am attending today based on my current calendar
- **Jira Tickets**: One line per open Jira ticket I am currently assigned to
- **Unread Emails**: One line per email in my inbox that I have not yet read.

When I perform my daily routine, the "Tasks" section should be updated with the latest information available from these sources.

### Calendar Access

Use `icalBuddy` to fetch today's meetings from the macOS Calendar app:

```bash
icalBuddy -ic "Calendar" eventsToday
```

#### Formatting
- Format each meeting as: `- HH:MM Meeting Name`
- Use 24-hour time format
- Skip the following event types:
  - Lunch
  - Focus Time

### Jira Access

Instructions for accessing Jira are stored in the /jira skill.

#### Formatting
- Format each ticket as: `- Jira:<TICKET-KEY>`
- Obsidian will automatically render the ticket information and status via a plugin
- Do not include the summary or status in the line; only the `Jira:<KEY>` format is needed

#### Exclusions
- Exclude tickets with status "Needs More Info"
- Exclude tickets in the Done status category (e.g., Done, Closed, Fixed, Dismissed)

### Email Access

Instructions for accessing the macOS Mail app are stored in the "mail" skill.

#### Formatting
- Format each email as: `- [Sender Name] Subject Line`
- Truncate long subject lines if needed for readability
- Limit to the 10 most recent unread emails to keep the list manageable

## Obsidian Tagging Review

This step should be performed after the completion of the Obsidian Daily Note.
Recently modified notes in the /obsidian vault should be reviewed for content and tagged appropriately.
The content of the notes themselves should not be modified, only the front matter.

Guidance for this action:

- Use the `obsidian` CLI to surface and modify notes. Do not enumerate the filesystem.
- Only look at notes modified within the last 7 days
- The following directories should be skipped:
  - "archive"
  - "attachments"
  - "daily"
  - "Clippings"
  - "docs"
  - "repositories"
