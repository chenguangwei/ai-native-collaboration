---
description: Cancel an active background Codex job in this repository
argument-hint: '[job-id]'
disable-model-invocation: true
allowed-tools: Bash(node:*)
---

```bash
_CODEX_ROOT=$(ls -d ~/.claude/plugins/cache/openai-codex/codex/*/ 2>/dev/null | sort -V | tail -1 | tr -d '\n' | sed 's|/$||')
node "$_CODEX_ROOT/scripts/codex-companion.mjs" cancel $ARGUMENTS
```
