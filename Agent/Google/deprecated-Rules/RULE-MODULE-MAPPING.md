# Google Rules to Modular Mapping

This file documents where each legacy non-GEMINI rule now lives in the modular architecture.

## Notes
- Active rules authority is `Rules/GEMINI.md`.
- Legacy full rule bodies remain in this folder (`deprecated-Rules/`).
- Compatibility wrappers were moved to `deprecated-Rules/compatibility-wrappers/`.

## Mapping
| Legacy rule file | Canonical module(s) |
|---|---|
| `agent_context_rules.md` | `Workflows/context-governance.md`, `Rules/GEMINI.md` |
| `archive_rules.md` | `Workflows/context-governance.md`, `Skills/archive-manager/SKILL.md`, `Rules/GEMINI.md` |
| `code_standards.md` | `Workflows/quality-gates.md`, `Rules/GEMINI.md` |
| `code_style_rules.md` | `Skills/code-style-enforcer/SKILL.md`, `Rules/GEMINI.md` |
| `communication_protocols.md` | `Skills/communication-protocol-enforcer/SKILL.md`, `Rules/GEMINI.md` |
| `documentation_standards.md` | `Workflows/quality-gates.md`, `Skills/documentation-generator/SKILL.md`, `Rules/GEMINI.md` |
| `environment_rules.md` | `Rules/GEMINI.md`, `Skills/runtime-safety-enforcer/SKILL.md` |
| `error_handling_rules.md` | `Skills/runtime-safety-enforcer/SKILL.md`, `Rules/GEMINI.md` |
| `logging_standards.md` | `Skills/runtime-safety-enforcer/SKILL.md`, `Rules/GEMINI.md` |
| `testing_rules.md` | `Workflows/quality-gates.md`, `Workflows/test-developer.md`, `Rules/GEMINI.md` |
| `tool_selection_rules.md` | `Skills/tool-selection-router/SKILL.md`, `Rules/GEMINI.md` |
| `workflow_router.md` | `Workflows/task-router.md`, `Rules/GEMINI.md` |
