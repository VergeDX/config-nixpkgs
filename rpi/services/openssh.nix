{ ... }:
let keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlS5xCmnWS2vMoP2ESJ4navm2CzhgbolMKhqJGxbwa/ osu_Vanilla@126.com" ];
in
{
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;

  # https://github.com/serokell/deploy-rs/issues/25#issuecomment-740067529
  users.users = {
    "vanilla".openssh.authorizedKeys.keys = keys;
    "root".openssh.authorizedKeys.keys = keys;
  };

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
