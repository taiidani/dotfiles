---
name: obsidian
description: Provides instructions on how to work with Obsidian. Use when the user asks to to perform anything in Obsidian such as managing notes, daily notes, tasks, search, metadata, or vault settings.
---

# Obsidian

This skill provides information about the user's personal preferences when working in Obsidian. Use this skill when the user asks to interact with Obsidian content or tooling.

Before performing any actions with Obsidian, confirm that the https://github.com/kepano/obsidian-skills Skills repository has been installed on the machine. You can confirm this by loading the `/obsidian-cli` skill. If the skill does not exist, halt the operation immediately and perform the installation described in the Skills repository, directing the user through its setup.

## Operating Principles

1. Prefer Obsidian CLI commands over direct filesystem edits when possible.
2. Prefer native daily-note commands (`daily*`) instead of filename/date assumptions.
3. Use `vault=<name>` whenever the target vault is unclear or multiple vaults exist.
4. If unsure about command syntax, check live help first with `obsidian help` or `obsidian help <command>`.
5. For machine-readable output, add `format=json` when supported.

## Vault Guidance

Each vault has specific content in it that needs to be matched to the task being performed.

### hashicorp (Vault)

This is my work vault and is where most of my Obsidian work happens. For clarify, HashiCorp is a company I worked at that was acquired by IBM June, 2026, and while I still refer to my workplace as HashiCorp the names of the two companies are roughly equivalent.

Some information about this vault:

- The `archive/` folder contains historical information that was once useful to me but is no longer relevant. Old project work, notes that became stale, etc. When interacting in the vault this folder should be deprioritized as its information is very likely to be out of date or incorrect.
- The `daily/` folder contains all of my daily tracking notes. I use Obsidian's core Daily Note plugin for building out the notes. Its template is stored at `templates/daily`. When interacting with this, *always* prefer using `obsidian daily` CLI commands over direct filesystem access.
- The `interviews/` folder contains information about how I interview employees at HashiCorp (IBM) as well as recent interview notes that I'm still recording feedback into for submission into IBM's hiring portal.
- The `people/` folder contains information about the folk that I regularly interact with at work. It holds snippets of important conversations, reminders of discussion topics (such as 1:1 notes), and general information about the person such as the team they're on.
- The `teams/` folder contains information about the teams that I regularly interact with at work. It holds information like the points of contact for the team, summaries of and links to their mission, and information about projects that I'm collaborating (or have collaborated) with them on.

### merrett and ryan (Vault)

This is a personal vault for sharing information, tasks, and research with my partner.


### taiidani (Vault)

This is a personal vault for general note taking, tracking of personal projects, and storing of articles for later reading.
