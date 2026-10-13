{
  programs.rectangle = {
    enable = true;
    # Installed system-wide (modules/darwin/packages.nix) so the Accessibility
    # grant stays on /Applications/Nix Apps/Rectangle.app.
    package = null;
    defaults = {
      # Rectangle registers itself as a login item on startup when this is set.
      launchOnLogin = true;
      alternateDefaultShortcuts = true;
      allowAnyShortcut = true;
      subsequentExecutionMode = 1;
      wasWelcomeDisplayed = true;
      internalTilingNotified = true;
    };
  };
}
