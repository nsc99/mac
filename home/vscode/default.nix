{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ];
      userSettings = ./settings.json;
    };
  };
}
