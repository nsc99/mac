{
  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "claude"
    ];
    onActivation.cleanup = "zap";
  };
}
