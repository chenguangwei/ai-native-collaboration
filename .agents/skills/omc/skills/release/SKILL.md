---
name: release
description: Automated release workflow for oh-my-Codex
level: 3
---

# Release Skill

Automate the release process for oh-my-Codex.

## Usage

```
/oh-my-Codex:release <version>
```

Example: `/oh-my-Codex:release 2.4.0` or `/oh-my-Codex:release patch` or `/oh-my-Codex:release minor`

## Release Checklist

Execute these steps in order:

### 1. Version Bump
Update version in all locations:
- `package.json`
- `src/installer/index.ts` (VERSION constant)
- `src/__tests__/installer.test.ts` (expected version)
- `.Codex-plugin/plugin.json`
- `.Codex-plugin/marketplace.json` (both `plugins[0].version` and root `version`)
- `docs/AGENTS.md` (`<!-- OMC:VERSION:X.Y.Z -->` marker)
- `README.md` (version badge and title)

### 2. Run Tests
```bash
npm run test:run
```
All 231+ tests must pass before proceeding.

### 3. Commit Version Bump
```bash
git add -A
git commit -m "chore: Bump version to <version>"
```

### 4. Create & Push Tag
```bash
git tag v<version>
git push origin main
git push origin v<version>
```

### 5. Publish to npm
```bash
npm publish --access public
```

### 6. Create GitHub Release
```bash
gh release create v<version> --title "v<version> - <title>" --notes "<release notes>"
```

### 7. Verify
- [ ] npm: https://www.npmjs.com/package/oh-my-Codex
- [ ] GitHub: https://github.com/Yeachan-Heo/oh-my-Codex/releases

## Version Files Reference

| File | Field/Line |
|------|------------|
| `package.json` | `"version": "X.Y.Z"` |
| `src/installer/index.ts` | `export const VERSION = 'X.Y.Z'` |
| `src/__tests__/installer.test.ts` | `expect(VERSION).toBe('X.Y.Z')` |
| `.Codex-plugin/plugin.json` | `"version": "X.Y.Z"` |
| `.Codex-plugin/marketplace.json` | `plugins[0].version` + root `version` |
| `docs/AGENTS.md` | `<!-- OMC:VERSION:X.Y.Z -->` |
| `README.md` | Title + version badge |

## Semantic Versioning

- **patch** (X.Y.Z+1): Bug fixes, minor improvements
- **minor** (X.Y+1.0): New features, backward compatible
- **major** (X+1.0.0): Breaking changes

## Notes

- Always run tests before publishing
- Create release notes summarizing changes
- Plugin marketplace syncs automatically from GitHub releases
