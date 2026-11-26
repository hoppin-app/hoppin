# hoppin — parent repo

This folder is the hoppin umbrella: every subfolder below is its **own git
repo** (a submodule). Commit, branch and open pull requests inside the
subfolder you changed, never here, unless you are bumping submodule pointers.

| Folder | Context file |
|---|---|
| `ios/` | `ios/HopChat-1/CLAUDE.md` — app code map and conventions |
| `server/` | `server/README.md` — environment variables, running, tests |
| `website/` | `website/CLAUDE.md` — Next.js 16 rules |
| `lib/` | `lib/README.md` — fixtures and the end-to-end run |
| `docs/` | `docs/README.md` — `DESIGN_CONTRACT.md` is the binding protocol spec |

Branch model, review and release rules: `CONTRIBUTING.md`. Feature work goes
on `ft/<name>` from `development`; `main` only receives releases and hotfixes.
