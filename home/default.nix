{
  imports = [
    ./shell.nix
    ./git.nix
    ./gh.nix
    ./ghostty.nix
    ./rectangle.nix
    ./sops.nix
    ./anki
    ./vscode
    ./claude-code
    ./apps.nix
    ./lab.nix
  ];

  home.stateVersion = "26.05";
}
