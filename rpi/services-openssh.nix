{ ... }:
{
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  users.users.vanilla.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlS5xCmnWS2vMoP2ESJ4navm2CzhgbolMKhqJGxbwa/ osu_Vanilla@126.com" ];

  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
}
