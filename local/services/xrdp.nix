{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ xmonad-with-packages xterm ];
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "xmonad";
}
