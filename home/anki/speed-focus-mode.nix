# Not in nixpkgs; packaged like pkgs.ankiAddons.*. AnkiWeb 1046608507.
{
  lib,
  anki-utils,
  fetchFromGitHub,
}:
anki-utils.buildAnkiAddon (finalAttrs: {
  pname = "speed-focus-mode";
  version = "1.0.0-unstable-2023-02-01";
  src = fetchFromGitHub {
    owner = "glutanimate";
    repo = "speed-focus-mode";
    rev = "f9f409ce151a629d6395d7cf2572935e587d6c16";
    hash = "sha256-6gr4XbiXYowSPRM1A0wQvYHBLCGgvbk6cGNm6+Dtats=";
  };
  sourceRoot = "${finalAttrs.src.name}/src/speed_focus_mode";
  meta = {
    description = "Auto-alert, auto-reveal and auto-answer timers for the Anki reviewer";
    homepage = "https://github.com/glutanimate/speed-focus-mode";
    license = lib.licenses.agpl3Plus;
  };
})
