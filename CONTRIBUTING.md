# Contributing

Two people, five repos, one set of rules. The same rules apply in every repo
(`ios`, `server`, `website`, `lib`, `docs`) and in this parent.

## Branches

| Branch | Holds | Who writes to it |
|---|---|---|
| `main` | The last stable, released version. Every commit on `main` is a release and is tagged. | Pull requests from `development` (a release) or `hotfix/*` only |
| `development` | Finished work waiting for the next release. The default branch on GitHub. | Pull requests from `ft/*` and `fix/*` |
| `ft/<name>` | One feature in progress, e.g. `ft/group-photos` | You, directly |
| `fix/<name>` | One bug fix, e.g. `fix/receipt-duplicates` | You, directly |
| `hotfix/<name>` | An urgent fix to what is released | You, directly |

`main` and `development` are protected: no direct pushes, no force pushes, no
deletion. A pull request needs the other person's approval and green CI.

## Day to day

```bash
git switch development && git pull
git switch -c ft/group-photos
# ...commit...
git push -u origin ft/group-photos     # then open a PR into development
```

- Keep a pull request to one concern; say what changed, why, and how you
  tested it. Link the issue it closes.
- Feature and fix PRs are **squash-merged** into `development`, and the
  branch is deleted.
- Commit subjects are short and imperative ("Add group photo picker"); the
  body says why.

## Releasing

1. Open a PR from `development` into `main`, titled with the version.
2. CI and the end-to-end run (`lib/run_tests.sh`) must pass; the other person
   approves.
3. Merge it with a **merge commit**, never squash, so `main` and
   `development` keep one shared history.
4. Tag the merge commit on `main`: `v1.0.3`. For the app, the tag matches
   the App Store version.
5. In this parent repo, move `main` to the released versions (below).

## Hotfixes

Branch `hotfix/<name>` from `main`, PR it into `main`, tag a patch version,
then merge `main` back into `development` so the fix is not lost.

## The parent repo and its submodules

Each folder here is pinned to one commit of its repo. The parent's `main`
pins released versions; its `development` pins the children's `development`.
Every submodule is set to `branch = .`: it follows the branch of the same
name as the parent's current branch.

```bash
git submodule update --remote --merge   # bring every folder to the tip of its branch
git add ios server website lib docs
git commit -m "Bump to the current development tips"
```

Committing inside `ios/` does not move the parent; the bump above does. Bump
the parent's `development` when a set of changes works together, and its
`main` at every release.

## Changing the protocol

A change to the wire format, certificates, sealing or the server's policy
touches three repos, in this order:

1. `docs`: change `DESIGN_CONTRACT.md`.
2. `server` and `lib`: change the server, regenerate
   `lib/fixtures/crypto_vectors.json` with `lib/make_vectors.py`, tag `lib`.
3. `ios`: implement it against the new fixtures.

Both test suites assert against the same fixtures, so a half-done change
fails in CI instead of in the field.

## Secrets

Never commit keys, tokens, certificates, state files or `.env` files. The
relay's keys live only on the server; CI secrets live in GitHub environments.
CI scans every push for leaked secrets.
