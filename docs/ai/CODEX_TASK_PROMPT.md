# Compact Codex task prompts

## Bug fix

Investigate and fix: `<symptom>`. Reproduce or trace the issue, identify the
root cause, make the smallest durable change, and run the tests/checks relevant
to the affected flow. Report cause, files changed, validation, and residual
risk. Do not broaden scope.

## Feature implementation

Implement: `<outcome and acceptance criteria>`. First locate the established
pattern and affected boundaries. Make a focused implementation, add focused
tests for the acceptance criteria, and validate adjacent error/empty/loading
behavior. Report files changed, validation, and any decision requiring follow-up.

## Code review

Review `<scope>` for correctness, regressions, security, typing, accessibility,
and maintainability. Prioritize concrete findings with file/line references and
severity. Do not edit files unless asked. State explicitly when no material
issues are found and note validation gaps.

## Refactoring

Refactor `<target>` to achieve `<goal>` without changing observable behavior.
Map callers and dependencies first, preserve contracts, keep the diff focused,
and run targeted regression checks. Report the preserved behavior, changed
boundaries, validation, and remaining risks.

## Session handoff

Create a concise handoff for `<task>`: current objective, completed work,
changed files, validation performed and results, known blockers, and the single
best next action. Distinguish confirmed facts from assumptions. Do not repeat
repository-wide guidance.

## Prompt compression

Compress this request while preserving outcome, constraints, acceptance
criteria, scope exclusions, and required validation: `<request>`. Remove
background, duplicated rules, optional detail, and implementation speculation.
Return only the compact prompt, with unresolved decisions marked clearly.
