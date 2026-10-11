{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      # No theme: the prompt comes from starship.
      theme = "";
      plugins = [
        "git"
        "sudo"
        "z"
        "colored-man-pages"
      ];
    };

    # zsh binds ^U to kill-whole-line; make it kill only what's left of the
    # cursor so Ghostty's cmd+backspace behaves like it does in macOS text fields.
    initContent = ''
      bindkey '^U' backward-kill-line
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables.EDITOR = "vim";
}
