---
name: graphify
description: Use for debugging, architecture analysis, dependency tracing, impact analysis, and code navigation in this repository.
---

# Graphify repository workflow

1. Start with one focused `graphify query "<task-specific question>"`. Run at
   most two initial Graphify queries; use `graphify path` or `graphify explain`
   only to resolve an identified relationship or symbol.
2. Never read `graphify-out/graph.json` directly. Inspect only the files and
   symbols identified by Graphify, then verify the relevant result against the
   current source code.
3. Use a targeted `rg` search only when Graphify evidence is incomplete. Keep
   the search limited to the implicated symbol, file, or dependency boundary.
4. Diagnose the root cause before editing. Prefer the smallest permanent fix
   consistent with the repository architecture; avoid unrelated cleanup.
5. Run only validation relevant to the changed behavior and its immediate
   regression risk. Update the graph with `graphify update .` only after
   meaningful code changes.

For explicit `/graphify` requests, follow the installer-managed Graphify skill.
