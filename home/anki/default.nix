{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Off in CI (darwinConfigurations.mac-ci): the audio collection is a
  # requireFile that a fresh runner cannot fetch.
  options.anki.localAudio = lib.mkEnableOption "the Yomitan local audio add-on" // {
    default = true;
  };

  config = {
    sops.secrets.anki-sync-username.key = "anki/username";
    sops.secrets.anki-sync-key.key = "anki/key";

    programs.anki = {
      enable = true;
      package = pkgs.anki;
      profiles.nsc99 = {
        default = true;
        sync = {
          usernameFile = config.sops.secrets.anki-sync-username.path;
          keyFile = config.sops.secrets.anki-sync-key.path;
        };
      };
      addons = [
        pkgs.ankiAddons.anki-connect
        (pkgs.ankiAddons.passfail2.withConfig {
          config = {
            again_button_name = "poor";
            good_button_name = "splendid";
          };
        })
        (pkgs.callPackage ./speed-focus-mode.nix { })
      ]
      ++ lib.optional config.anki.localAudio (pkgs.callPackage ./local-audio.nix { });
    };

    home.packages = [ (pkgs.callPackage ./app.nix { inherit config; }) ];
  };
}
