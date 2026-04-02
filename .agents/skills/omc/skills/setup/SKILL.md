---
name: setup
description: Unified setup entrypoint for install, diagnostics, and MCP configuration
level: 2
---

# Setup

Use `/oh-my-Codex:setup` as the unified setup/configuration entrypoint.

## Usage

```bash
/oh-my-Codex:setup                # full setup wizard
/oh-my-Codex:setup doctor         # installation diagnostics
/oh-my-Codex:setup mcp            # MCP server configuration
/oh-my-Codex:setup wizard --local # explicit wizard path
```

## Routing

Route by the first argument:

- No argument, `wizard`, `local`, `global`, or `--force` -> run `/oh-my-Codex:omc-setup {{ARGUMENTS}}`
- `doctor` -> run `/oh-my-Codex:omc-doctor {{ARGUMENTS_AFTER_DOCTOR}}`
- `mcp` -> run `/oh-my-Codex:mcp-setup {{ARGUMENTS_AFTER_MCP}}`

Examples:

```bash
/oh-my-Codex:omc-setup {{ARGUMENTS}}
/oh-my-Codex:omc-doctor {{ARGUMENTS_AFTER_DOCTOR}}
/oh-my-Codex:mcp-setup {{ARGUMENTS_AFTER_MCP}}
```

## Notes

- `/oh-my-Codex:omc-setup`, `/oh-my-Codex:omc-doctor`, and `/oh-my-Codex:mcp-setup` remain valid compatibility entrypoints.
- Prefer `/oh-my-Codex:setup` in new documentation and user guidance.

Task: {{ARGUMENTS}}
