# Phase 1 â€” upstream assessment

Status: complete on 2026-09-28. This document records inspection findings only; it does not claim that the upstream runtime or a TV connection has been run on this computer.

## Sources inspected

| Source | Revision inspected | Purpose |
| --- | --- | --- |
| [isair/jarvis](https://github.com/isair/jarvis) | `30c46ca8bf4929e9cad31ceca56dd704ddc288f0` | Local-assistant foundation |
| [hamsaleem/TCL-TV-Remote](https://github.com/hamsaleem/TCL-TV-Remote) | `2cac4d68e6a07aa07f8565b5ca3e790d76b65526` | Existing Android TV Edge extension and Node companion |
| [@kud/androidtv-remote](https://github.com/kud/androidtv-remote) | API documentation inspected | Android TV Remote v2 protocol library |

## Upstream Jarvis architecture

The upstream project is a Python application with a PyQt6 desktop/tray interface and a daemon. Its useful extension seams are:

- `jarvis.llm`: provider factory with Ollama and OpenAI-compatible HTTP adapters.
- `jarvis.tools`: built-in tool registry, tool selection, approval-capable agentic reply loop, and external MCP runtime.
- `jarvis.memory`: local SQLite conversation/diary/graph storage.
- `desktop_app`: settings, chat, logs, setup, tray, and memory viewer.

The upstream project provides Windows builds and a PowerShell source launcher. Its source setup expects Python 3.12 and prefers Micromamba. Neither Python, Micromamba, nor Ollama was installed when this assessment was made; Node.js 24 and Git were present.

## Windows assessment

The project can be made reliable on Windows, but Windows is not upstream's primary development platform. The following are deliberate Phase 2 checks rather than assumptions:

| Item | Assessment | Phase 2 action |
| --- | --- | --- |
| PyQt desktop and tray UI | Windows-targeted code and packaged release exist. | Run the upstream smoke test on this machine. |
| GPU acceleration | NVIDIA GeForce GTX 1070, 8 GB VRAM, driver 582.28. Current Ollama supports this compute-capability family with a driver newer than 570. | Install Ollama only after approval and verify GPU offload from logs. |
| Local model | `qwen3.5:4b` is a 3.4 GB Ollama model and fits with reasonable headroom on this GPU. Upstream's curated model list does not yet list this exact tag. | Test a short chat and a tool call before adopting it as the default. |
| Storage paths | Some upstream defaults use Unix-style `~/.local` paths even on Windows. | Route Jervis-owned data to `%LOCALAPPDATA%\\Jervis`. |
| macOS-only behavior | MLX Whisper, AppleScript/Ollama.app handling, macOS crash diagnostics, and a macOS automation catalogue entry are platform-guarded. | Do not carry macOS integrations into the Windows configuration. |
| MCP command discovery | The upstream fallback search list is mainly macOS/Linux; normal Windows `PATH` resolution remains available. | Use explicit executable paths for any Windows sidecar. |

## License boundary

Upstream Jarvis is licensed for non-commercial use and requires derivatives to retain the same license. Jervis is planned as a personal local assistant. Public non-commercial publication is permitted subject to retention of the upstream copyright notice and license terms for any upstream-derived code. Commercial use of upstream-derived software requires a separate license. The upstream source checkout and release binaries are not included in this repository.

## TCL Android TV Remote assessment

The existing project already has the correct local-network split:

- An unchanged Edge extension presents the remote UI.
- A Node.js companion listens only on `127.0.0.1:38473`.
- The companion pairs with the TV using the Android TV Remote v2 TLS certificate flow.
- Existing endpoints cover status, connect, pair, key presses, and text input.

The current bridge already covers power-key, volume, mute, navigation, Home, Back, media keys, and text. The underlying protocol library also documents deep-link app launch and power/volume/current-app events. Those functions are not currently exposed by the bridge, so Jervis will add them only after dependency-version and live-TV verification. Playback metadata is not presently established and is explicitly out of scope until verified.

### Required hardening before integration

1. Replace the hard-coded TV address with user configuration.
2. Keep the Edge extension unchanged; Jervis consumes the existing loopback protocol through a narrow client.
3. Move or protect pairing certificates with Windows-backed credential storage. POSIX `0600` file mode is not sufficient protection on Windows.
4. Restrict bridge origins to the extension/Jervis origin where this remains compatible with the extension.
5. Add health, reconnect, timeout, and unavailable-TV error tests.
6. Start the companion at user sign-in with a hidden per-user Task Scheduler task, only after the direct launch path is tested.

## Phase 1 exit criteria

- [x] Project directory selected and write permission verified.
- [x] Local Git repository initialized and pushed to a private GitHub remote; publication review is pending.
- [x] Upstream architecture, license, Windows requirements, and macOS-specific code assessed.
- [x] GPU identified and model candidate selected subject to runtime testing.
- [x] Existing TV protocol and missing capabilities identified.
- [x] Secret-safe ignore rules, design documentation, and a layout validation test added.
