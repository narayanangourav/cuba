# Repository policy

## Scope and discovery

- Inspect the affected code, configuration, tests, and documentation before editing.
- Keep changes minimal, root-cause focused, and consistent with local patterns.
- Do not change unrelated code or perform opportunistic cleanup. State material assumptions and plan multi-file or behavior-changing work.
- A nested `AGENTS.md`, if present, governs its directory tree and takes precedence over this file.

## Platform and layout

- This is a React 19 + TypeScript Ionic application built with Vite. Use npm; `package-lock.json` is lockfile v3. CI uses Node 24.x; no project-local Node version is declared.
- Primary code is in `src/`: `app/` routes/overlays, `pages/` screens, `components/` reusable UI, `hooks/`, `redux/`, `services/`, `startup/`, `utility/`, `ops-console/`, `teachers-module/`, `stories/`, and `tests/` mocks/helpers.
- `src/index.tsx` bootstraps startup services and renders `App`; preserve this initialization order when changing startup or native behavior.
- Vite resolves `@` to `src`; retain that alias in application and Storybook imports/configuration.
- `android/` is the Capacitor Android project; `capacitor.config.ts` defines native plugins and reads `.env.local`. `firebase.json` defines Hosting targets. Treat `.github/workflows/` as CI/release automation.
- Supabase and Firebase are service boundaries. Preserve API/auth contracts and validate backend-facing changes against the active schema, RLS, and environment configuration.

## Commands and validation

- Install with `npm install`. Start web development with `npm start`; it runs Vite on port 3000.
- Required when relevant: `npm run lint` for changed `src` JavaScript/TypeScript; `npm test -- <target>` for focused Jest tests; `npm run build` for production/type/build validation.
- Optional, when relevant: `npm run storybook`, `npm run build:storybook`, `npm run build:android`, and `cd android && ./gradlew assembleDebug` for the affected UI, documentation, Capacitor, or Android flow.
- `npm run format` and `npm run lint:fix` modify files; do not use them unless formatting/fixing is in scope. The pre-commit hook runs `lint-staged`, including `prettier --check` for staged Markdown, CSS, JSON, and source files.
- Jest uses jsdom, `src/setupTests.ts`, and `src/tests/__mocks__/`; reuse existing mocks and add/update focused tests for changed behavior. Update Storybook stories for reusable UI when applicable.
- Test happy, error, loading, empty, offline/native, and persistence behavior only where the change can affect them. Do not run a full suite for a small isolated change without a relevant risk.

## Code and persistence

- Keep `.tsx` focused on presentation. Put business logic, validation, transformations, and API access in hooks, services, or utilities; do not define nested components.
- Use strict TypeScript: no new `any`, unsafe casts, silent fallbacks, or unchecked null/empty/malformed data. Use guard clauses and explicit async error handling.
- Follow `.prettierrc` and ESLint: 2 spaces, single quotes, semicolons, trailing commas, 80-column formatting, and no `console` calls. Comments explain why; remove dead code rather than commenting it out.
- Use semantic accessible UI, buttons for actions, dedicated CSS (no inline styles), and namespaced kebab-case CSS classes. Reuse shared components before adding new ones.
- Redux Persist stores `auth` and `growthbook`; native code uses Capacitor Preferences and the app supports SQLite. Do not alter persisted keys, transforms, native version-reset behavior, or local database data/schema without a compatibility, migration, and rollback plan.
- Do not store secrets, credentials, tokens, or sensitive PII in browser storage, Redux persistence, logs, or source. Sanitize user input and validate API responses before use.

## Database, native, and generated artifacts

- No versioned Supabase migrations are present. Do not invent, run, or apply database migrations or production schema changes without explicit backend authorization; keep `src/services/database.ts` and service contracts aligned with approved schema changes.
- Do not modify Android build output, Capacitor-generated web assets, `dist/`, `build/`, `coverage/`, `storybook-static/`, `node_modules/`, Graphify outputs/caches, signing files, `google-services.json`, or environment files unless explicitly required.
- Change `package.json` and `package-lock.json` together only for an approved dependency change. Reuse installed dependencies first; never hand-edit the lockfile.
- Keep Firebase, Supabase, Capawesome, Sentry, analytics, and Android configuration environment-specific; never hardcode, log, or commit their secrets.

## Git, skills, and reporting

- Do not stage, commit, push, merge, rebase, switch branches, rewrite history, change hooks, or install dependencies unless explicitly requested. Preserve pre-existing working-tree changes.
- Review `git diff --check`, the complete relevant diff, and `git status --short` before handoff. Do not modify CI, release, native, or deployment configuration outside task scope.
- Use applicable `.agents/skills/` instructions. Treat `.codex/skills/graphify/` and `.codex/hooks.json` as installer-managed unless the task explicitly targets them.
- For repository questions, start with one focused Graphify query when a graph exists; use `path`/`explain` only as needed, never read `graphify-out/graph.json` directly, and verify results in current source. Update the graph only after meaningful source changes; see `docs/ai/GRAPHIFY.md` for operations.
- Final reports state the root cause or outcome, files changed, tests/checks run and skipped, regression risks, assumptions, and any required follow-up.
