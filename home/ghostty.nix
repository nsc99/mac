{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # The source-built `ghostty` package is Linux-only.
    package = pkgs.ghostty-bin;
    settings = {
      background-opacity = 0.85;
      background-blur = true;
      keybind = [
        # cmd+backspace: delete from cursor to start of line (^U)
        "super+backspace=text:\\x15"
        # cmd+fn+backspace (cmd+forward-delete): delete from cursor to end of line (^K)
        "super+delete=text:\\x0b"
      ];
    };
  };
}
