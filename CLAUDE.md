# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

nix-darwin + home-manager flake for a single Apple Silicon Mac (`darwinConfigurations.mac`, user `nsc99`). There are no tests or linters; "does it build" is the check.

## Commands

```sh
# Flakes only see git-tracked files: always `git add` new/renamed files first
git add -A

# Verify a change builds (do this after every edit)
nix build .#darwinConfigurations.mac.system --no-link

# See what a change does to the installed system (empty output = no package changes)
nix store diff-closures /run/current-system \
  $(nix eval --raw .#darwinConfigurations.mac.system.outPath)

# Inspect available home-manager options for a program (e.g. git)
nix eval .#darwinConfigurations.mac.options.home-manager.users.type \
  --apply 't: builtins.attrNames (t.getSubOptions []).programs.git'

# Apply (needs sudo; leave this to the user)
darwin-rebuild switch --flake .#mac

# Edit secrets (age key at ~/.config/sops/age/keys.txt)
sops secrets/secrets.yaml
```

## Architecture

- `flake.nix` only defines inputs and a `mkDarwin { hostname, user }` helper that loads `hosts/<hostname>` + `modules/darwin`. Both `inputs` and `user` are passed as `specialArgs`, so modules take `{ inputs, user, ... }` instead of hardcoding the username or destructuring inputs in `outputs`.
- `hosts/<hostname>/default.nix` holds machine-specific settings (platform, user account, `stateVersion`) and is where `home-manager.users.${user}` is pointed at `home/`.
- `modules/darwin/` is system-level config; `default.nix` imports each file. `home-manager.nix` there wires in home-manager and sops-nix (both darwin and HM modules) and forwards `inputs` to HM via `extraSpecialArgs`.
- `home/` is home-manager config; `home/default.nix` imports one file (or directory with `default.nix`) per program. Non-Nix assets live next to the module that uses them (e.g. `home/vscode/settings.json`).
- `overlays/default.nix` is a single overlay applied in `modules/darwin/nix.nix`; with `useGlobalPkgs = true` it also applies to home-manager.
- Secrets: `secrets/secrets.yaml` is sops-encrypted (rules in `.sops.yaml`). Modules declare `sops.secrets.<name>.key = "path/in/yaml"` and consume `config.sops.secrets.<name>.path` (see `home/anki/default.nix`). Never commit it decrypted.

New program → add `home/<name>.nix`, import it in `home/default.nix`, `git add`, build.

## Commits

- Conventional commits: `type(scope): subject` (e.g. `feat(ghostty): ...`, `chore: ...`), one logical change per commit, each commit must build on its own.
- No `Co-Authored-By` or other AI attribution trailers in commit messages.
- Never push (no `git push`, `gh repo create --push`, etc.); committing locally is fine, pushing is left to the user.

## Gotchas

- Many nixpkgs GUI apps are Linux-only from source on darwin; check `meta.platforms` and look for a `-bin` variant (Ghostty uses `pkgs.ghostty-bin`).
- Prefer home-manager's current option names (e.g. `programs.git.settings.user.*`, not deprecated `userName`/`userEmail`); check with the options eval above.
- `homebrew.onActivation.cleanup = "zap"`: any cask not listed in `modules/darwin/homebrew.nix` is uninstalled on switch.
- `home/vscode/settings.json` points nixd at `darwinConfigurations.mac` for option completion; renaming the config breaks that. It also references `nixfmt`, which isn't installed.
- `home/anki/app.nix` builds a tiny `Anki.app` that execs the home-manager `anki` wrapper so launches from Finder/Spotlight use the configured profile and addons.
