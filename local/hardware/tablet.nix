{ ... }:
{
  services.xserver.wacom.enable = true;
  services.xserver.digimend.enable = true;

  # https://opentabletdriver.net/Wiki/Install/Linux
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
}
