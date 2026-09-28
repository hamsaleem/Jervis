# Windows readiness — Phase 1

## Verified

- Project directory: `D:\Codex Projects\Jervis`
- Write access: verified with a temporary write/read/remove probe.
- Node.js: `v24.19.0`
- Git: `2.43.0.windows.1`
- GPU: NVIDIA GeForce GTX 1070, 8 GB VRAM
- NVIDIA driver: `582.28`

## Not installed or verified

- Python 3.12
- Micromamba
- Ollama
- Upstream Jarvis runtime dependencies
- TCL companion dependencies
- Any local model

Nothing in this phase installs software or contacts an email provider or TV.

## Planned Phase 2 prerequisites

1. Python 3.12 plus Micromamba, following the upstream Windows launcher.
2. Ollama for Windows, configured to stay local at `127.0.0.1:11434`.
3. `qwen3.5:4b` only after Ollama GPU detection succeeds.
4. A smoke-test configuration with web search, location, external MCP servers, and cloud providers disabled.

## Security baseline

- Keep the application bound to loopback unless a later remote-access design is explicitly approved.
- Do not place credentials in `config/jervis.local.json`, `.env`, SQLite backups, commits, or logs.
- Use the checked-in `config/jervis.example.json` only as a non-secret template.
- Review every new integration's permissions before enabling it.
