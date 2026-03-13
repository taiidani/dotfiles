---
name: obsidian
description: Interact with Obsidian vaults using the Obsidian CLI to manage files, notes, properties, tasks, plugins, and more. Use when the user asks to work with Obsidian or when performing deeper research more specific to the user or not readily available.
---

Use this skill when the user asks to interact with Obsidian, manage notes, search content, handle tasks, configure plugins, or work with their Obsidian vault.

## Obsidian CLI Overview

The Obsidian CLI allows comprehensive interaction with Obsidian vaults from the command line. Run `obsidian help` to see all available commands. This is always up to date. Full docs: https://help.obsidian.md/cli

**Basic syntax:**
```
obsidian <command> [options]
```

**Global options:**
- `vault=<name>` - Target a specific vault by name

**Important notes:**
- File resolves by name (like wikilinks), path is exact (folder/note.md)
- Most commands default to the active file when file/path is omitted
- Quote values with spaces: `name="My Note"`
- Use `\n` for newline, `\t` for tab in content values

## File Management Commands

### create
Create a new file
```
obsidian create name="My Note" content="# My Note\n\nContent here"
obsidian create path="Projects/New Project.md" template="Project Template"
obsidian create name="Meeting Notes" open newtab
```
Options:
- `name=<name>` - File name
- `path=<path>` - File path
- `content=<text>` - Initial content
- `template=<name>` - Template to use
- `overwrite` - Overwrite if file exists
- `open` - Open file after creating
- `newtab` - Open in new tab

### read
Read file contents
```
obsidian read file="My Note"
obsidian read path="Daily/2024-01-15.md"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path

### open
Open a file in Obsidian
```
obsidian open file="My Note"
obsidian open path="Projects/Project.md" newtab
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `newtab` - Open in new tab

### delete
Delete a file
```
obsidian delete file="Old Note"
obsidian delete path="Archive/old.md" permanent
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `permanent` - Skip trash, delete permanently

### move
Move or rename a file
```
obsidian move file="My Note" to="Archive/"
obsidian move path="Notes/old.md" to="Notes/new.md"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `to=<path>` - Destination folder or path (required)

### rename
Rename a file
```
obsidian rename file="Old Name" name="New Name"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `name=<name>` - New file name (required)

### append
Append content to a file
```
obsidian append file="Daily Note" content="\n## New Section\n\nContent"
obsidian append path="Tasks.md" content="- New task" inline
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `content=<text>` - Content to append (required)
- `inline` - Append without newline

### prepend
Prepend content to a file
```
obsidian prepend file="My Note" content="# Title\n\n"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `content=<text>` - Content to prepend (required)
- `inline` - Prepend without newline

## Listing and Discovery Commands

### files
List files in the vault
```
obsidian files
obsidian files folder="Projects"
obsidian files ext="md" total
```
Options:
- `folder=<path>` - Filter by folder
- `ext=<extension>` - Filter by extension
- `total` - Return file count

### folders
List folders in the vault
```
obsidian folders
obsidian folders folder="Projects" total
```
Options:
- `folder=<path>` - Filter by parent folder
- `total` - Return folder count

### file
Show file info
```
obsidian file file="My Note"
obsidian file path="Projects/Project.md"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path

### folder
Show folder info
```
obsidian folder path="Projects"
obsidian folder path="Archive" info=size
```
Options:
- `path=<path>` - Folder path (required)
- `info=files|folders|size` - Return specific info only

### recents
List recently opened files
```
obsidian recents
obsidian recents total
```
Options:
- `total` - Return recent file count

### random
Open a random note
```
obsidian random
obsidian random folder="Projects" newtab
```
Options:
- `folder=<path>` - Limit to folder
- `newtab` - Open in new tab

### random:read
Read a random note
```
obsidian random:read
obsidian random:read folder="Daily"
```
Options:
- `folder=<path>` - Limit to folder

## Search Commands

### search
Search vault for text
```
obsidian search query="machine learning"
obsidian search query="TODO" path="Projects" limit=10
obsidian search query="important" case format=json
```
Options:
- `query=<text>` - Search query (required)
- `path=<folder>` - Limit to folder
- `limit=<n>` - Max files
- `total` - Return match count
- `case` - Case sensitive
- `format=text|json` - Output format (default: text)

### search:context
Search with matching line context
```
obsidian search:context query="TODO" format=json
```
Options:
- `query=<text>` - Search query (required)
- `path=<folder>` - Limit to folder
- `limit=<n>` - Max files
- `case` - Case sensitive
- `format=text|json` - Output format (default: text)

### search:open
Open search view
```
obsidian search:open query="machine learning"
```
Options:
- `query=<text>` - Initial search query

## Link and Graph Commands

### links
List outgoing links from a file
```
obsidian links file="My Note"
obsidian links path="Projects/Project.md" total
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `total` - Return link count

### backlinks
List backlinks to a file
```
obsidian backlinks file="My Note"
obsidian backlinks path="Index.md" counts format=json
```
Options:
- `file=<name>` - Target file name
- `path=<path>` - Target file path
- `counts` - Include link counts
- `total` - Return backlink count
- `format=json|tsv|csv` - Output format (default: tsv)

### orphans
List files with no incoming links
```
obsidian orphans
obsidian orphans total all
```
Options:
- `total` - Return orphan count
- `all` - Include non-markdown files

### deadends
List files with no outgoing links
```
obsidian deadends
obsidian deadends total all
```
Options:
- `total` - Return dead-end count
- `all` - Include non-markdown files

### unresolved
List unresolved links in vault
```
obsidian unresolved
obsidian unresolved counts verbose format=json
```
Options:
- `total` - Return unresolved link count
- `counts` - Include link counts
- `verbose` - Include source files
- `format=json|tsv|csv` - Output format (default: tsv)

## Task Management Commands

### tasks
List tasks in the vault
```
obsidian tasks
obsidian tasks todo verbose
obsidian tasks file="Projects" format=json
obsidian tasks status="!" done
```
Options:
- `file=<name>` - Filter by file name
- `path=<path>` - Filter by file path
- `total` - Return task count
- `done` - Show completed tasks
- `todo` - Show incomplete tasks
- `status="<char>"` - Filter by status character
- `verbose` - Group by file with line numbers
- `format=json|tsv|csv` - Output format (default: text)
- `active` - Show tasks for active file
- `daily` - Show tasks from daily note

### task
Show or update a task
```
obsidian task ref="Tasks.md:15" toggle
obsidian task file="Daily Note" line=10 done
obsidian task path="Projects/Project.md" line=5 status=">"
```
Options:
- `ref=<path:line>` - Task reference (path:line)
- `file=<name>` - File name
- `path=<path>` - File path
- `line=<n>` - Line number
- `toggle` - Toggle task status
- `done` - Mark as done
- `todo` - Mark as todo
- `daily` - Use daily note
- `status="<char>"` - Set status character

## Properties (Frontmatter) Commands

### properties
List properties in the vault
```
obsidian properties
obsidian properties file="My Note"
obsidian properties name="tags" counts
obsidian properties sort=count format=json
```
Options:
- `file=<name>` - Show properties for file
- `path=<path>` - Show properties for path
- `name=<name>` - Get specific property count
- `total` - Return property count
- `sort=count` - Sort by count (default: name)
- `counts` - Include occurrence counts
- `format=yaml|json|tsv` - Output format (default: yaml)
- `active` - Show properties for active file

### property:read
Read a property value from a file
```
obsidian property:read name="tags" file="My Note"
obsidian property:read name="status" path="Projects/Project.md"
```
Options:
- `name=<name>` - Property name (required)
- `file=<name>` - File name
- `path=<path>` - File path

### property:set
Set a property on a file
```
obsidian property:set name="status" value="in-progress" file="My Note"
obsidian property:set name="tags" value="project,important" type=list path="Project.md"
obsidian property:set name="created" value="2024-01-15" type=date
```
Options:
- `name=<name>` - Property name (required)
- `value=<value>` - Property value (required)
- `type=text|list|number|checkbox|date|datetime` - Property type
- `file=<name>` - File name
- `path=<path>` - File path

### property:remove
Remove a property from a file
```
obsidian property:remove name="draft" file="My Note"
```
Options:
- `name=<name>` - Property name (required)
- `file=<name>` - File name
- `path=<path>` - File path

## Tags Commands

### tags
List tags in the vault
```
obsidian tags
obsidian tags file="My Note"
obsidian tags counts sort=count format=json
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `total` - Return tag count
- `counts` - Include tag counts
- `sort=count` - Sort by count (default: name)
- `format=json|tsv|csv` - Output format (default: tsv)
- `active` - Show tags for active file

### tag
Get tag info
```
obsidian tag name="project"
obsidian tag name="important" verbose total
```
Options:
- `name=<tag>` - Tag name (required)
- `total` - Return occurrence count
- `verbose` - Include file list and count

## Aliases Commands

### aliases
List aliases in the vault
```
obsidian aliases
obsidian aliases file="My Note"
obsidian aliases verbose total
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `total` - Return alias count
- `verbose` - Include file paths
- `active` - Show aliases for active file

## Template Commands

### templates
List templates
```
obsidian templates
obsidian templates total
```
Options:
- `total` - Return template count

### template:read
Read template content
```
obsidian template:read name="Meeting Template"
obsidian template:read name="Daily Note" resolve title="Today's Note"
```
Options:
- `name=<template>` - Template name (required)
- `resolve` - Resolve template variables
- `title=<title>` - Title for variable resolution

### template:insert
Insert template into active file
```
obsidian template:insert name="Meeting Template"
```
Options:
- `name=<template>` - Template name (required)

## Bookmarks Commands

### bookmarks
List bookmarks
```
obsidian bookmarks
obsidian bookmarks verbose format=json
```
Options:
- `total` - Return bookmark count
- `verbose` - Include bookmark types
- `format=json|tsv|csv` - Output format (default: tsv)

### bookmark
Add a bookmark
```
obsidian bookmark file="Important.md"
obsidian bookmark folder="Projects"
obsidian bookmark url="https://example.com" title="Example"
obsidian bookmark search="TODO"
```
Options:
- `file=<path>` - File to bookmark
- `subpath=<subpath>` - Subpath (heading or block) within file
- `folder=<path>` - Folder to bookmark
- `search=<query>` - Search query to bookmark
- `url=<url>` - URL to bookmark
- `title=<title>` - Bookmark title

## Outline Commands

### outline
Show headings for a file
```
obsidian outline file="My Note"
obsidian outline path="Index.md" format=json
obsidian outline format=md total
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `format=tree|md|json` - Output format (default: tree)
- `total` - Return heading count

### wordcount
Count words and characters
```
obsidian wordcount file="Essay"
obsidian wordcount path="Writing/Story.md" words
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `words` - Return word count only
- `characters` - Return character count only

## Plugin Management Commands

### plugins
List installed plugins
```
obsidian plugins
obsidian plugins filter=community versions format=json
```
Options:
- `filter=core|community` - Filter by plugin type
- `versions` - Include version numbers
- `format=json|tsv|csv` - Output format (default: tsv)

### plugins:enabled
List enabled plugins
```
obsidian plugins:enabled
obsidian plugins:enabled filter=core
```
Options:
- `filter=core|community` - Filter by plugin type
- `versions` - Include version numbers
- `format=json|tsv|csv` - Output format (default: tsv)

### plugin
Get plugin info
```
obsidian plugin id="obsidian-git"
```
Options:
- `id=<plugin-id>` - Plugin ID (required)

### plugin:enable
Enable a plugin
```
obsidian plugin:enable id="obsidian-git"
obsidian plugin:enable id="workspaces" filter=core
```
Options:
- `id=<id>` - Plugin ID (required)
- `filter=core|community` - Plugin type

### plugin:disable
Disable a plugin
```
obsidian plugin:disable id="obsidian-git"
```
Options:
- `id=<id>` - Plugin ID (required)
- `filter=core|community` - Plugin type

### plugin:install
Install a community plugin
```
obsidian plugin:install id="obsidian-git" enable
```
Options:
- `id=<id>` - Plugin ID (required)
- `enable` - Enable after install

### plugin:uninstall
Uninstall a community plugin
```
obsidian plugin:uninstall id="obsidian-git"
```
Options:
- `id=<id>` - Plugin ID (required)

### plugin:reload
Reload a plugin (for developers)
```
obsidian plugin:reload id="my-plugin"
```
Options:
- `id=<id>` - Plugin ID (required)

### plugins:restrict
Toggle or check restricted mode
```
obsidian plugins:restrict
obsidian plugins:restrict on
obsidian plugins:restrict off
```
Options:
- `on` - Enable restricted mode
- `off` - Disable restricted mode

## Theme Management Commands

### themes
List installed themes
```
obsidian themes
obsidian themes versions
```
Options:
- `versions` - Include version numbers

### theme
Show active theme or get info
```
obsidian theme
obsidian theme name="Minimal"
```
Options:
- `name=<name>` - Theme name for details

### theme:set
Set active theme
```
obsidian theme:set name="Minimal"
obsidian theme:set name=""
```
Options:
- `name=<name>` - Theme name (empty for default) (required)

### theme:install
Install a community theme
```
obsidian theme:install name="Minimal" enable
```
Options:
- `name=<name>` - Theme name (required)
- `enable` - Activate after install

### theme:uninstall
Uninstall a theme
```
obsidian theme:uninstall name="Minimal"
```
Options:
- `name=<name>` - Theme name (required)

## CSS Snippets Commands

### snippets
List installed CSS snippets
```
obsidian snippets
```

### snippets:enabled
List enabled CSS snippets
```
obsidian snippets:enabled
```

### snippet:enable
Enable a CSS snippet
```
obsidian snippet:enable name="my-snippet"
```
Options:
- `name=<name>` - Snippet name (required)

### snippet:disable
Disable a CSS snippet
```
obsidian snippet:disable name="my-snippet"
```
Options:
- `name=<name>` - Snippet name (required)

## Command Execution

### commands
List available command IDs
```
obsidian commands
obsidian commands filter="editor:"
```
Options:
- `filter=<prefix>` - Filter by ID prefix

### command
Execute an Obsidian command
```
obsidian command id="editor:toggle-bold"
obsidian command id="workspace:close"
```
Options:
- `id=<command-id>` - Command ID to execute (required)

### hotkeys
List hotkeys
```
obsidian hotkeys
obsidian hotkeys verbose format=json all
```
Options:
- `total` - Return hotkey count
- `verbose` - Show if hotkey is custom
- `format=json|tsv|csv` - Output format (default: tsv)
- `all` - Include commands without hotkeys

### hotkey
Get hotkey for a command
```
obsidian hotkey id="editor:toggle-bold"
obsidian hotkey id="workspace:close" verbose
```
Options:
- `id=<command-id>` - Command ID (required)
- `verbose` - Show if custom or default

## Workspace and Tabs

### tabs
List open tabs
```
obsidian tabs
obsidian tabs ids
```
Options:
- `ids` - Include tab IDs

### tab:open
Open a new tab
```
obsidian tab:open file="My Note.md"
obsidian tab:open group="main"
```
Options:
- `group=<id>` - Tab group ID
- `file=<path>` - File to open
- `view=<type>` - View type to open

### workspace
Show workspace tree
```
obsidian workspace
obsidian workspace ids
```
Options:
- `ids` - Include workspace item IDs

## Version History Commands

### history
List file history versions
```
obsidian history file="My Note"
obsidian history path="Projects/Project.md"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path

### history:list
List files with history
```
obsidian history:list
```

### history:read
Read a file history version
```
obsidian history:read file="My Note" version=1
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `version=<n>` - Version number (default: 1)

### history:restore
Restore a file history version
```
obsidian history:restore file="My Note" version=2
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `version=<n>` - Version number (required)

### history:open
Open file recovery
```
obsidian history:open file="My Note"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path

## Sync Commands

### sync:status
Show sync status
```
obsidian sync:status
```

### sync
Pause or resume sync
```
obsidian sync on
obsidian sync off
```
Options:
- `on` - Resume sync
- `off` - Pause sync

### sync:history
List sync version history for a file
```
obsidian sync:history file="My Note"
obsidian sync:history path="Project.md" total
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `total` - Return version count

### sync:read
Read a sync version
```
obsidian sync:read file="My Note" version=1
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `version=<n>` - Version number (required)

### sync:restore
Restore a sync version
```
obsidian sync:restore file="My Note" version=2
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `version=<n>` - Version number (required)

### sync:deleted
List deleted files in sync
```
obsidian sync:deleted
obsidian sync:deleted total
```
Options:
- `total` - Return deleted file count

### sync:open
Open sync history
```
obsidian sync:open file="My Note"
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path

### diff
List or diff local/sync versions
```
obsidian diff file="My Note"
obsidian diff path="Project.md" from=1 to=2
obsidian diff file="Note" filter=local
```
Options:
- `file=<name>` - File name
- `path=<path>` - File path
- `from=<n>` - Version number to diff from
- `to=<n>` - Version number to diff to
- `filter=local|sync` - Filter by version source

## Database (Base) Commands

### bases
List all base files in vault
```
obsidian bases
```

### base:views
List views in the current base file
```
obsidian base:views
```

### base:query
Query a base and return results
```
obsidian base:query file="Database" view="All Items"
obsidian base:query path="Data/DB.md" view="Active" format=json
```
Options:
- `file=<name>` - Base file name
- `path=<path>` - Base file path
- `view=<name>` - View name to query
- `format=json|csv|tsv|md|paths` - Output format (default: json)

### base:create
Create a new item in a base
```
obsidian base:create file="Database" view="All Items" name="New Item"
obsidian base:create path="DB.md" name="Item" content="Content" open
```
Options:
- `file=<name>` - Base file name
- `path=<path>` - Base file path
- `view=<name>` - View name
- `name=<name>` - New file name
- `content=<text>` - Initial content
- `open` - Open file after creating
- `newtab` - Open in new tab

## Vault Management

### vaults
List known vaults
```
obsidian vaults
obsidian vaults verbose total
```
Options:
- `total` - Return vault count
- `verbose` - Include vault paths

### vault
Show vault info
```
obsidian vault
obsidian vault info=name
obsidian vault info=files
```
Options:
- `info=name|path|files|folders|size` - Return specific info only

## System Commands

### version
Show Obsidian version
```
obsidian version
```

### reload
Reload the vault
```
obsidian reload
```

### restart
Restart the app
```
obsidian restart
```

### help
Show list of all available commands
```
obsidian help
obsidian help search
```
Options:
- `<command>` - Show help for a specific command

## Developer Commands

### dev:console
Show captured console messages
```
obsidian dev:console
obsidian dev:console limit=100 level=error
obsidian dev:console clear
```
Options:
- `clear` - Clear the console buffer
- `limit=<n>` - Max messages to show (default 50)
- `level=log|warn|error|info|debug` - Filter by log level

### dev:errors
Show captured errors
```
obsidian dev:errors
obsidian dev:errors clear
```
Options:
- `clear` - Clear the error buffer

### dev:debug
Attach/detach Chrome DevTools Protocol debugger
```
obsidian dev:debug on
obsidian dev:debug off
```
Options:
- `on` - Attach debugger
- `off` - Detach debugger

### dev:mobile
Toggle mobile emulation
```
obsidian dev:mobile on
obsidian dev:mobile off
```
Options:
- `on` - Enable mobile emulation
- `off` - Disable mobile emulation

### dev:dom
Query DOM elements
```
obsidian dev:dom selector=".markdown-preview-view"
obsidian dev:dom selector="h1" text all
obsidian dev:dom selector="button" attr="aria-label"
```
Options:
- `selector=<css>` - CSS selector (required)
- `total` - Return element count
- `text` - Return text content
- `inner` - Return innerHTML instead of outerHTML
- `all` - Return all matches instead of first
- `attr=<name>` - Get attribute value
- `css=<prop>` - Get CSS property value

### dev:css
Inspect CSS with source locations
```
obsidian dev:css selector=".markdown-preview-view"
obsidian dev:css selector="body" prop="background-color"
```
Options:
- `selector=<css>` - CSS selector (required)
- `prop=<name>` - Filter by property name

### dev:cdp
Run a Chrome DevTools Protocol command
```
obsidian dev:cdp method="Runtime.evaluate" params='{"expression":"1+1"}'
```
Options:
- `method=<CDP.method>` - CDP method to call (required)
- `params=<json>` - Method parameters as JSON

## Usage Guidelines

### When the user asks to work with Obsidian:

1. **Check vault availability**: Use `obsidian vaults` to list available vaults if not specified
2. **Target the correct vault**: Use `vault=<name>` option when working with specific vaults
3. **Use appropriate file reference**: Choose between `file=` (resolves by name like wikilinks) or `path=` (exact path)
4. **Format output appropriately**: Use `format=json` for programmatic processing, or default formats for readability
5. **Provide context**: When listing items, consider using `verbose` or `counts` options for more detail

### Common Workflows

**Daily note workflow:**
```
# Open today's daily note
obsidian open file="$(date +%Y-%m-%d)"

# Create daily note with template
obsidian create name="$(date +%Y-%m-%d)" template="Daily Note" open
```

**Task management:**
```
# List all incomplete tasks
obsidian tasks todo verbose

# Mark task as done
obsidian task file="Tasks" line=5 done

# Find all tasks with specific status
obsidian tasks status="!" format=json
```

**Content search and analysis:**
```
# Search for term with context
obsidian search:context query="TODO" format=json

# Find orphaned notes
obsidian orphans verbose

# List unresolved links
obsidian unresolved counts
```

**Metadata management:**
```
# Set property on multiple conditions
obsidian property:set name="status" value="done" file="Project"

# List all tags with counts
obsidian tags counts sort=count

# Read specific property
obsidian property:read name="created" file="Note"
```

**Plugin and theme management:**
```
# Install and enable plugin
obsidian plugin:install id="obsidian-git" enable

# Switch theme
obsidian theme:set name="Minimal"

# List enabled plugins
obsidian plugins:enabled format=json
```

### Error Handling

- Always check if vault exists before operations
- Verify file/path exists before reading or modifying
- Quote values containing spaces or special characters
- Use proper escaping for newlines (`\n`) and tabs (`\t`) in content
- Check command output for errors before proceeding

### Best Practices

1. **Use JSON format** for parsing output in scripts: `format=json`
2. **Get totals first** before listing large datasets: `total` flag
3. **Filter appropriately** to reduce output: use `folder=`, `path=`, `filter=` options
4. **Combine operations** efficiently rather than multiple separate calls
5. **Use templates** for consistent note creation
6. **Leverage properties** for metadata-driven workflows
7. **Check sync status** before major operations if using Obsidian Sync
