# Graphify setup and maintenance

Graphify is development-only repository-navigation tooling. It is not an
application, build, runtime, or production dependency. It accelerates
exploration but is never a source of truth; verify relevant relationships in
the current source before acting on them.

Repository-wide exploration rules live in `AGENTS.md`; the local Graphify skill
defines the query workflow. This document records installation and maintenance.

## Validated version and installation

This setup was validated with Graphify `0.9.18`. Install that pinned version
outside the application dependency tree:

```sh
uv tool install "graphifyy==0.9.18"
graphify install --project --platform codex
graphify extract . --code-only
```

The repository uses code-only extraction and needs no LLM API key. Run commands
from the repository root. `.graphifyignore` excludes dependencies, generated
assets, credentials, signing material, logs, and large binary media.

## Routine maintenance

Use `graphify update .` after meaningful source changes. Do not regenerate a
valid graph merely for documentation-only changes. Review the changed output
and relevant source after a refresh.

The committed graph artifacts are `graphify-out/graph.json` and
`graphify-out/GRAPH_REPORT.md`. Keep caches, manifests, transient analysis
files, memory/reflection files, credentials, and environment-specific values
out of commits. `graph.html` is intentionally not generated for this large
repository under Graphify's default visualization limit.

## Codex and hook integration

`.codex/skills/graphify/` and `.codex/hooks.json` are installer-managed files;
do not edit or remove them during normal repository work. The Codex hook is not
a Git hook. Husky remains the repository's Git hook manager.

Graphify Git hooks are intentionally disabled. To inspect their state, use:

```sh
graphify hook status
git config --get core.hooksPath
```

Do not install, remove, or alter Graphify or Husky hooks unless the task
explicitly authorizes it.

## Upgrading or rebuilding

For a Graphify upgrade, select a tested `graphifyy` release, install it pinned,
confirm `graphify --version`, update the version above, and deliberately run a
full `graphify extract . --code-only` only when regeneration is intended.
Review generated changes and confirm Graphify Git hooks remain disabled.
