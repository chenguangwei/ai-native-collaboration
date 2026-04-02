---
name: ask
description: Ask Codex, Codex, or Gemini via local CLI and capture a reusable artifact
---

# Ask

Use OMC's canonical advisor skill to route a prompt through the local Codex, Codex, or Gemini CLI and persist the result as an ask artifact.

## Usage

```bash
/oh-my-Codex:ask <Codex|codex|gemini> <question or task>
```

Examples:

```bash
/oh-my-Codex:ask codex "review this patch from a security perspective"
/oh-my-Codex:ask gemini "suggest UX improvements for this flow"
/oh-my-Codex:ask Codex "draft an implementation plan for issue #123"
```

## Routing

**Required execution path — always use this command:**

```bash
omc ask {{ARGUMENTS}}
```

**Do NOT manually construct raw provider CLI commands.** Never run `codex`, `Codex`, or `gemini` directly to fulfill this skill. The `omc ask` wrapper handles correct flag selection, artifact persistence, and provider-version compatibility automatically. Manually assembling provider CLI flags will produce incorrect or outdated invocations.

## Requirements

- The selected local CLI must be installed and authenticated.
- Verify availability with the matching command:

```bash
Codex --version
codex --version
gemini --version
```

## Artifacts

`omc ask` writes artifacts to:

```text
.omc/artifacts/ask/<provider>-<slug>-<timestamp>.md
```

Task: {{ARGUMENTS}}
