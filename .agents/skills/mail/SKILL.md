---
name: mail
description: Instructions for accessing the macOS Mail app via AppleScript. This includes fetching unread emails, reading message details, and interacting with mailboxes.
---

# macOS Mail Access

Access the macOS Mail app using AppleScript via the `osascript` command in the terminal.

## Prerequisites

- **Mail app must be running**: The Mail application needs to be open for these commands to work reliably.
- **Automation permissions**: The first time you run these commands, macOS will prompt you to grant your terminal app permission to control Mail. Approve this in System Preferences > Privacy & Security > Automation.

## Fetching Unread Emails

### Basic: List all unread emails from inbox

```bash
osascript -e '
tell application "Mail"
    set unreadMessages to (every message of inbox whose read status is false)
    repeat with msg in unreadMessages
        set msgSubject to subject of msg
        set msgSender to sender of msg
        set msgDate to date received of msg
        log msgSubject & " | " & msgSender & " | " & msgDate
    end repeat
end tell
'
```

### Detailed: Unread emails with more fields

```bash
osascript -e '
tell application "Mail"
    set unreadMessages to (every message of inbox whose read status is false)
    repeat with msg in unreadMessages
        set msgSubject to subject of msg
        set msgSender to sender of msg
        set msgDate to date received of msg
        set msgId to message id of msg
        log "---"
        log "Subject: " & msgSubject
        log "From: " & msgSender
        log "Date: " & msgDate
        log "ID: " & msgId
    end repeat
end tell
'
```

### All accounts: Unread emails across all mailboxes

```bash
osascript -e '
tell application "Mail"
    set allAccounts to every account
    repeat with acct in allAccounts
        set acctName to name of acct
        set acctMailboxes to every mailbox of acct
        repeat with mbox in acctMailboxes
            set unreadMessages to (every message of mbox whose read status is false)
            repeat with msg in unreadMessages
                set msgSubject to subject of msg
                set msgSender to sender of msg
                set msgDate to date received of msg
                log acctName & " | " & (name of mbox) & " | " & msgSubject & " | " & msgSender & " | " & msgDate
            end repeat
        end repeat
    end repeat
end tell
'
```

## Reading a Specific Message

To get the full content of a message, you can access its `content` property:

```bash
osascript -e '
tell application "Mail"
    set msg to first message of inbox whose read status is false
    set msgContent to content of msg
    log msgContent
end tell
'
```

## Limiting Results

To fetch only the first N unread messages (useful for large inboxes):

```bash
osascript -e '
tell application "Mail"
    set unreadMessages to (every message of inbox whose read status is false)
    set maxMessages to 10
    set msgCount to count of unreadMessages
    if msgCount > maxMessages then set msgCount to maxMessages
    repeat with i from 1 to msgCount
        set msg to item i of unreadMessages
        set msgSubject to subject of msg
        set msgSender to sender of msg
        log msgSubject & " | " & msgSender
    end repeat
end tell
'
```

## Output Formatting

When displaying unread emails for the daily routine or other purposes:

- Format each email as: `- [Sender Name] Subject Line`
- Truncate long subject lines if needed for readability
- Sort by date received (most recent first) when relevant

## Troubleshooting

- **"Mail got an error: Application isn't running"**: Open the Mail app and try again.
- **"Not authorized to send Apple events"**: Grant automation permissions in System Preferences > Privacy & Security > Automation.
- **Empty results**: Ensure you have unread emails in the mailbox you're querying, and that Mail has finished syncing.