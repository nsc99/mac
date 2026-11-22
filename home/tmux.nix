{
  programs.tmux = {
    enable = true;
    # Mouse wheel enters copy mode and scrolls tmux's history.
    mouse = true;
    historyLimit = 50000;
    extraConfig = ''
      # Ghostty's Option-Tab shortcuts open the session picker on first press.
      # Further presses move the selection; Enter switches, Escape cancels.
      bind-key Tab if-shell -F '#{==:#{pane_mode},tree-mode}' 'send-keys Down' 'choose-tree -s'
      bind-key BTab if-shell -F '#{==:#{pane_mode},tree-mode}' 'send-keys Up' 'choose-tree -s'
    '';
  };
}
