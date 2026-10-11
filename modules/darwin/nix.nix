{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (import ../../overlays) ];
}
