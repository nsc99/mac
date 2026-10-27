{
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    # Make Touch ID available to sudo inside tmux and screen.
    reattach = true;
  };
}
