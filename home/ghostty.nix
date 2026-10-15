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
        # opt+fn+backspace (opt+forward-delete): delete the word after the cursor (ESC d)
        "alt+delete=esc:d"
        # Send tmux's default prefix (^B) followed by its pane commands.
        # cmd+d: split right; cmd+shift+d: split down.
        "super+d=text:\\x02%"
        "super+shift+d=text:\\x02\\x22"
        # cmd+shift+arrows: move focus between tmux panes.
        "super+shift+left=text:\\x02\\x1b[D"
        "super+shift+right=text:\\x02\\x1b[C"
        "super+shift+up=text:\\x02\\x1b[A"
        "super+shift+down=text:\\x02\\x1b[B"
        # opt+tab / opt+shift+tab: open tmux's session picker, then navigate it.
        # These send prefix+Tab / prefix+BackTab; see tmux.nix.
        "alt+tab=text:\\x02\\x09"
        "alt+shift+tab=text:\\x02\\x1b[Z"
      ];
    };
  };
}
