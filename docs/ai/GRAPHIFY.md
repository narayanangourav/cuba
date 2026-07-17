# Graphify integration

## Purpose

Graphify is development-only tooling for navigating the repository as a code
knowledge graph. It is not an application, Node.js, Android, APK, build, or
production dependency.

Use the graph to accelerate exploration, but verify relationships against the
source code before making architectural changes.

## Tested version

This integration was validated with Graphify `0.9.18`.

## Installation

Install the tested, pinned version outside the application dependency tree:

```sh
uv tool install "graphifyy==0.9.18"
graphify install --project --platform codex
graphify extract . --code-only
```

The repository uses code-only extraction. It does not require an LLM API key.

## Included content

Run Graphify from the repository root. Code and supported repository files are
included unless excluded by `.graphifyignore`.

## Excluded content

`.graphifyignore` excludes dependency folders, generated build outputs,
coverage, Storybook output, Android build artifacts, temporary Supabase files,
the existing `graphify-out/` output, environment files, signing material,
release artifacts, logs, and large binary media assets.

Unsupported files, and files that produce zero nodes, may also be absent from
the graph.

## Output policy

Commit these repository artifacts when they are intentionally updated:

- `AGENTS.md`
- `.codex/skills/graphify/`
- `.codex/hooks.json`
- `docs/ai/GRAPHIFY.md`
- `graphify-out/graph.json`
- `graphify-out/GRAPH_REPORT.md`
- `graphify-out/.graphify_analysis.json`
- `graphify-out/manifest.json`
- `.gitignore`

Keep `graphify-out/cache/` ignored. The rule appears once in `.gitignore`.
Keep `.env` ignored as well. Do not commit Graphify caches, credentials, or
environment-specific values.

`graph.html` is intentionally skipped because this graph exceeds Graphify's
default 5,000-node visualization limit.

The current validated report, built from the current commit, records 8,175
nodes, 20,547 edges, and 478 communities.

## Graph refresh procedure

Create the initial graph with:

```sh
graphify extract . --code-only
```

After source changes, refresh it manually with:

```sh
graphify update .
```

Review the updated report and source code before relying on new or changed
relationships. Do not regenerate an existing valid graph merely for routine
documentation changes.

## Codex integration files

- `AGENTS.md` directs codebase exploration to the existing graph and requests
  a manual `graphify update .` after code changes.
- `.codex/skills/graphify/` provides the project Graphify skill and supporting
  instructions.
- `.codex/hooks.json` registers a Codex `PreToolUse` hook that runs Graphify's
  hook check. It is a Codex hook, not a Git hook.

## Git-hook policy

Graphify Git hooks are not enabled. Do not run:

```sh
graphify hook install
```

Check their status with:

```sh
graphify hook status
git config --get core.hooksPath
```

The repository's Git hook manager is Husky; its existing hook is
`.husky/pre-commit`. If Graphify hooks are ever found installed, do not remove
them automatically. First report the result, then remove them deliberately
with:

```sh
graphify hook uninstall
```

## Known limitations

The graph is an extracted aid, not a source of truth. Relationships can be
inferred, incomplete, or affected by unsupported file formats and files that
produce zero nodes. Large graphs do not produce `graph.html` under the default
visualization limit.

## Security restrictions

Never place API keys, tokens, credentials, private keys, or absolute local
environment values in Graphify documentation or outputs. This code-only setup
requires no LLM API key. Respect `.graphifyignore` and `.gitignore`, especially
their environment, signing-material, and generated-output exclusions.

## Upgrade procedure

1. Choose a tested `graphifyy` release.
2. Install it with a pinned version; replace the version in
   `uv tool install "graphifyy==0.9.18"` with the selected release.
3. Run `graphify --version` and update the tested-version section above.
4. Run `graphify extract . --code-only` only when a full regeneration is
   intended, then review the report and output changes.
5. Confirm `graphify hook status` still reports no installed Graphify Git hooks.

## Removal procedure

1. Confirm Graphify Git-hook status with `graphify hook status`.
2. If hooks are installed, remove them deliberately with `graphify hook
   uninstall`; do not remove Husky hooks.
3. Remove the external Graphify tool installation using the package manager
   that installed it.
4. Remove Graphify-specific repository files only in a separately reviewed
   change, including the Codex configuration, documentation, and generated
   outputs as applicable.

## Committed:
- graphify-out/graph.json
- graphify-out/GRAPH_REPORT.md

##  Not committed:
- graphify-out/cache/
- graphify-out/manifest.json
- graphify-out/.graphify_*
- graphify-out/memory/
- graphify-out/reflections/