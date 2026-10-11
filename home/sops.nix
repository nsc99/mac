{ config, ... }:
let
  keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in
{
  home.sessionVariables.SOPS_AGE_KEY_FILE = keyFile;

  sops = {
    age.keyFile = keyFile;
    defaultSopsFile = ../secrets/secrets.yaml;
  };
}
