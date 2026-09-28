# Jervis

Jervis is a local-first personal AI assistant for Windows. It is being built in small, approval-gated phases from the upstream [isair/jarvis](https://github.com/isair/jarvis) project, beginning with TCL Android TV control and multi-account email management.

## Attribution and license

Jervis is an independent integration project designed around [isair/jarvis](https://github.com/isair/jarvis), copyright (c) 2025 Baris Sencan. The original Jarvis source is not included in this repository. The separately downloaded upstream checkout is excluded from Git. When distributing adapted upstream code, preserve the original copyright notice and apply the upstream non-commercial license in [LICENSE](LICENSE). Commercial use of upstream-derived software requires permission from its copyright holder.

## Project status

This is an early-stage planning and integration repository, not a working Jarvis replacement. The upstream Jarvis runtime, TV bridge, email integration and Qwen model are **not** bundled here. To try the original assistant, visit the upstream repository. The TCL TV remote is maintained separately at [hamsaleem/TCL-TV-Remote](https://github.com/hamsaleem/TCL-TV-Remote).

## Current phase

Phase 1 is complete: repository inspection, Windows compatibility assessment, security boundary design, and a project-layout validation check. No application runtime, AI model, TV credential, email account, or cloud AI service has been installed or configured.

## Development phases

1. Inspect upstream Jarvis and TCL TV Remote; document compatibility and architecture.
2. Bring the pinned upstream foundation up locally on Windows.
3. Integrate the existing TCL Android TV companion and Edge extension.
4. Add the multi-account email module.
5. Connect integrations to natural-language tools with explicit action approvals.
6. Build and test the unified dashboard.

Each phase ends with automated checks, documentation, a local Git commit, and an approval checkpoint before the next phase begins.

## Documentation

- [Phase 1 assessment](docs/phase-1-assessment.md)
- [Architecture proposal](docs/architecture.md)
- [Windows readiness](docs/windows-readiness.md)

## Validate Phase 1

```powershell
pwsh -NoProfile -File tests/phase1/validate-project-layout.ps1
```

This check validates the approved project layout and confirms that no known local credential files have entered the repository.
