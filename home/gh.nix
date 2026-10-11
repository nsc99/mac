{
  programs.gh = {
    enable = true;
    # Clone/push over SSH with ~/.ssh keys instead of HTTPS tokens.
    gitCredentialHelper.enable = false;
    settings.git_protocol = "ssh";
  };
}
