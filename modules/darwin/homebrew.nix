{
  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "claude"
      "tailscale-app"
    ];
    onActivation.cleanup = "zap";
  };
}
