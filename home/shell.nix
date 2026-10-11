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
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables.EDITOR = "vim";
}
