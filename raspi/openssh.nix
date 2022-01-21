{ ... }:
{
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # https://github.com/serokell/deploy-rs/issues/25#issuecomment-740067529
  users.users."root".openssh.authorizedKeys.keys =
    [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVpgJtK1tTpURq6XH3xibH+6VdU8/2igxpQs4aAkaoy" ];
}
