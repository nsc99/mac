{
  imports = [
    ./shell.nix
    ./tmux.nix
    ./git.nix
    ./gh.nix
    ./ghostty.nix
    ./rectangle.nix
    ./sops.nix
    ./anki
    ./vscode
    ./ai
    ./apps.nix
    ./lab.nix
  ];

  home.stateVersion = "26.05";
}
