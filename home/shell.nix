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
    presets = [ "plain-text-symbols" ];
    # Show the current kube context and namespace (the module is off by default).
    # Blue so it stands apart from the (cyan) directory; "k8s" overrides the
    # preset's "kubernetes " symbol.
    settings.kubernetes = {
      disabled = false;
      symbol = "k8s ";
      style = "bold blue";
    };
  };

  home.sessionVariables.EDITOR = "vim";
}
