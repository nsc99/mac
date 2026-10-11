{
  imports = [
    ./shell.nix
    ./git.nix
    ./ghostty.nix
    ./sops.nix
    ./anki
    ./vscode
    ./apps.nix
  ];

  home.stateVersion = "26.05";
}
