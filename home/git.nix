{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "nsc99";
        email = "nils@schweigert.gg";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    ignores = [ ".DS_Store" ];
  };
}
