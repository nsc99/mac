{ inputs, user, ... }:
{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
  };

  system.primaryUser = user;

  home-manager.users.${user} = ../../home;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
