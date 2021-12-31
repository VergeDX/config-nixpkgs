{ ... }:
{
  systemd.services."plymouth-quit" = {
    enable = false;
  };
}
