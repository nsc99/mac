{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "nsc99";
        email = "mail@schweigert.xyz";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    ignores = [ ".DS_Store" ];
  };
}
