{ ... }:
{
  services.fail2ban.enable = true;
  services.fail2ban.bantime-increment.enable = true;
  services.fail2ban.ignoreIP = [ "127.0.0.1" ];
}
