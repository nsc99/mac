{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Ghostty's Option-Tab shortcuts open the session picker on first press.
      # Further presses move the selection; Enter switches, Escape cancels.
      bind-key Tab if-shell -F '#{==:#{pane_mode},tree-mode}' 'send-keys Down' 'choose-tree -s'
      bind-key BTab if-shell -F '#{==:#{pane_mode},tree-mode}' 'send-keys Up' 'choose-tree -s'
    '';
  };
}
