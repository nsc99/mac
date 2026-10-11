{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "nsc99";
        email = "nsc99@schweigert.xyz";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    ignores = [ ".DS_Store" ];
  };
}
