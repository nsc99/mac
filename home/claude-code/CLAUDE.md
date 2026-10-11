# Versions

Never write a version from memory. Before putting any version into a file
(dependencies, CI actions, toolchains, images, flake inputs, ...), look it up,
and say which version you found and where.

- Prefer what the project already pins: lock files, `go.mod`, the flake's
  nixpkgs, etc. "Latest" is only right when nothing constrains it.
- If you can't verify a version, say so instead of guessing.

Where to look (`jq` and `curl` work everywhere; use the native tool if present):

| What | How |
|---|---|
| GitHub releases / Actions | `gh api repos/<owner>/<repo>/releases/latest --jq .tag_name` or `git ls-remote --tags --refs --sort=-v:refname https://github.com/<owner>/<repo> 'v*' \| head -1` |
| Go toolchain | `curl -fsSL 'https://go.dev/dl/?mode=json' \| jq -r '.[0].version'` |
| Go modules | `go list -m <module>@latest` or `curl -fsSL https://proxy.golang.org/<module>/@latest \| jq -r .Version` |
| Nix packages | `nix eval --inputs-from . --raw nixpkgs#<pkg>.version` (the flake's pinned nixpkgs), `nix eval --raw nixpkgs#<pkg>.version` (registry), `nix search nixpkgs '^<pkg>$'`, search.nixos.org |
| Flake inputs | `nix flake metadata` (locked revs), `nix flake update <input>` to bump |
| npm | `npm view <pkg> version` or `curl -fsSL https://registry.npmjs.org/<pkg>/latest \| jq -r .version` |
| PyPI | `curl -fsSL https://pypi.org/pypi/<pkg>/json \| jq -r .info.version` |
| crates.io | `cargo search <crate> --limit 1` or `curl -fsSL -A <agent> https://crates.io/api/v1/crates/<crate> \| jq -r .crate.max_stable_version` |

For anything else, check the project's releases page or registry, not memory.
