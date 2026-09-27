---
name: go
description: Provides guidance on best practices when working with code written in Go.
---

# Go Best Practices Skill

Use this skill when the user asks to write Go code or for coding guidance, code review feedback, or "best practices" recommendations.

Keep advice short, practical, and action-oriented.

## Core Rules

- Prefer clarity over cleverness.
- Keep functions small and focused.
- Accept interfaces, return concrete types.
- Handle errors explicitly; do not hide them.
- Wrap errors with context using `fmt.Errorf("...: %w", err)`.
- Pass `context.Context` as the first argument for request-scoped work.
- Avoid global mutable state.
- Write table-driven tests for logic-heavy code.

## Ready-for-Review Checklist

- Run `go test ./...`.
- Run `go test -race ./...` for concurrent code changes.
- Run `go vet ./...`.
- Run `gofmt -w` (or `go fmt ./...`) and ensure formatting is clean.
- Confirm exported names have doc comments.

## Style Guidance for Responses

- Give 3-7 bullets max unless the user asks for depth.
- Prefer "Do X" over long explanations.
- Include concrete commands when useful.
- Mention trade-offs only when they affect a decision.

## Example Guidance

- "Always run `go vet ./...` before considering code ready for review."
- "Return early on errors to keep happy paths easy to scan."
- "Use table-driven tests for branching logic so adding cases stays cheap."
