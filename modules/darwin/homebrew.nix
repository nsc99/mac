{
  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "claude"
      "mullvad-vpn"
      "tailscale-app"
    ];
    onActivation.cleanup = "zap";
  };
}
