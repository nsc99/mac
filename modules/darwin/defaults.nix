{ user, ... }:
{
  system.defaults = {
    NSGlobalDomain = {
      # Trackpad/mouse: false = "natural" scrolling off
      "com.apple.swipescrolldirection" = false;
      # Keyboard: lower is faster (units of 15 ms); these are the fastest UI values
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
    };

    # Keyboard Shortcuts > Input Sources. Note: this replaces the whole
    # AppleSymbolicHotKeys dict, so unlisted shortcuts revert to macOS defaults.
    CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys = {
      # 60 = "Select the previous input source" (ctrl+space)
      "60" = {
        enabled = false;
        value = {
          type = "standard";
          parameters = [
            32
            49
            262144
          ];
        };
      };
    };
  };

  # Apply shortcut changes without logging out
  system.activationScripts.postActivation.text = ''
    sudo -u ${user} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
