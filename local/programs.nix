{ ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.fish.enable = true;
  programs.thefuck.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # Required by https://github.com/blackjackshellac/eclipse
  programs.gpaste.enable = true;
}
