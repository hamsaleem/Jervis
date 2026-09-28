# Jervis architecture proposal

## Design principles

- Local by default: no external model, public listener, or remote access is enabled by default.
- Replaceable adapters: model, TV, email, memory, notifications, and UI integrations depend on interfaces rather than vendor-specific code.
- Explicit approval: sending email and other sensitive operations are commands requiring a user confirmation step.
- Least data: secret material stays in Windows credential storage; database records retain only the data needed for the selected feature.
- Resource-aware: deterministic APIs handle predictable work; the local model is reserved for language interpretation, summaries, and reply drafts.

## Module boundaries

```text
PyQt dashboard / future authenticated web dashboard
                  |
            application services
     approvals | notifications | audit log
                  |
       integration contracts and tool adapters
          |             |              |
      TV adapter     Email adapter   Memory adapter
          |             |              |
  local Node bridge  OAuth/IMAP     future Hindsight
          |
   TCL Android TV / existing Edge extension

       Local model provider contract
  Ollama (default) | compatible local server | optional cloud (off)
```

## Contracts to introduce

| Contract | Responsibilities | Secret policy |
| --- | --- | --- |
| `ModelProvider` | chat, structured tool selection, summarization | Endpoint token only in credential store if needed. |
| `TvController` | connection state, approved commands, capability discovery | Pairing certificate outside SQLite and Git. |
| `EmailAccountProvider` | OAuth/IMAP sync, search, drafts, send after approval | OAuth refresh token or password only in credential store. |
| `MemoryStore` | conversation/project boundaries and redacted facts | Never accepts email credentials, raw OAuth tokens, or secret fields. |
| `ActionApproval` | creates, displays, confirms, expires, and audits sensitive actions | Audit metadata only; never secret values. |

## Data placement

| Data type | Planned location | Included in Git? |
| --- | --- | --- |
| Source, tests, sample configuration, documentation | Project workspace | Yes |
| Jervis SQLite database and logs | `%LOCALAPPDATA%\\Jervis` | No |
| TV pairing material, email OAuth tokens, optional cloud keys | Windows Credential Manager through an established credential-store library | No |
| Model weights | Ollama-managed local model directory | No |
| Edge extension | Existing TV project, preserved separately | No automatic copy or modification in Phase 1 |

## Integration strategy

TV begins as an HTTP client to the existing loopback companion rather than a protocol rewrite. Email begins with provider-specific adapters behind a common incremental-sync contract: Gmail and Outlook use OAuth; IMAP is available only where the provider supports secure authentication. The dashboard consumes only normalized account/message metadata and always displays the owning account.

The upstream Jarvis tool registry is the initial natural-language execution seam. New tools will expose narrow, typed operations such as `tv.volume_up` and `email.create_draft`; they will not expose arbitrary shell or network access.
