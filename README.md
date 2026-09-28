# Jervis

Jervis is a local-first personal AI assistant for Windows. It is being built in small, approval-gated phases from the upstream [isair/jarvis](https://github.com/isair/jarvis) project, beginning with TCL Android TV control and multi-account email management.

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
