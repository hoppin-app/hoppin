# hoppin

An end-to-end encrypted iOS messenger that keeps working when the internet
doesn't. Messages travel phone to phone over the local network, hop between
nearby phones over Bluetooth, and otherwise wait on a relay that stores only
sealed envelopes it cannot read.

This is the parent repo. It holds no product code: each part of hoppin is
its own repo, pinned here as a submodule at versions that work together.

| Folder | Repo | What it is |
|---|---|---|
| `ios/` | [hoppin-app/ios](https://github.com/hoppin-app/ios) | The iPhone app: SwiftUI, iOS 18+, Swift 6 |
| `server/` | [hoppin-app/server](https://github.com/hoppin-app/server) | Verification server and encrypted relay (Python) |
| `website/` | [hoppin-app/website](https://github.com/hoppin-app/website) | hoppin.chat (Next.js) |
| `lib/` | [hoppin-app/lib](https://github.com/hoppin-app/lib) | Shared crypto test vectors and the end-to-end test run |
| `docs/` | [hoppin-app/docs](https://github.com/hoppin-app/docs) | The protocol spec, architecture, operations, App Store material |

## Getting started

```bash
git clone --recursive git@github.com:hoppin-app/hoppin.git
cd hoppin
scripts/setup.sh
```

`setup.sh` initialises the submodules, makes `git pull` keep them in step,
and creates the server's Python environment.

## Working on it

Work happens **inside** each folder, in that repo: branch from `development`,
open a pull request there. The parent only moves when a set of versions is
known to work together. [`CONTRIBUTING.md`](CONTRIBUTING.md) has the branch
model, review rules and release steps.

## Testing everything

```bash
lib/run_tests.sh             # real dev server + server tests + app unit, UI and integration tests
SKIP_XCODE=1 lib/run_tests.sh
```

## Where to read more

- How a message travels, and the security model: [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
- The binding protocol spec: [`docs/DESIGN_CONTRACT.md`](docs/DESIGN_CONTRACT.md)
- The relay deployment: [`docs/ops/DEPLOY.md`](docs/ops/DEPLOY.md)

## License

None yet. All rights reserved until one is chosen.
